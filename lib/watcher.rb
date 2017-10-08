require 'json'
require 'open_api_parser'

module Watcher
  class Railtie < ::Rails::Railtie
    initializer 'open api' do |app|
      docs_paths = Dir.glob("docs/*.json")
      open_api_reloader = ActiveSupport::FileUpdateChecker.new(docs_paths) do
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

      app.reloaders << open_api_reloader

      config.to_prepare do
        open_api_reloader.execute_if_updated
      end
    end
  end
end
