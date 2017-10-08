require 'json'
require 'open_api_parser'

class OpenApiReloader
  def initialize(app)
    @app = app
    docs_paths = Dir.glob("docs/*.json")
    @open_api_reloader = ActiveSupport::FileUpdateChecker.new(docs_paths) do
      begin
        OpenApiParser::Specification.resolve(
          Rails.root.join('docs', 'swagger.json'), validate_meta_schema: true
        )
        puts 'OpenAPI doc has been successfully validated.'
      rescue JsonSchema::AggregateError, JsonSchema::SchemaError, JsonSchema::ValidationError => e
        warn 'OpenAPI doc generation failed.'
        warn e.to_s
      end
    end
    @open_api_reloader.execute
  end

  def call(env)
    @open_api_reloader.execute_if_updated
    @app.call(env)
  end
end

Rails.application.config.middleware.use OpenApiReloader if Rails.env.development?
