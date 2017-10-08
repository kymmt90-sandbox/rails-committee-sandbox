class Railties < ::Rails::Railtie
  initializer '' do |app|
    watcher = ActiveSupport::FileUpdateChecker.new([], { Rails.root.join('docs').to_s => ['.json'] }) do
      Rails.logger.info 'updated'
      # begin
      #   OpenApiParser::Specification.resolve(
      #     Rails.root.join('docs', 'swagger.json'), validate_meta_schema: true
      #   )
      #   puts 'OpenAPI doc has been successfully validated.'
      # rescue JsonSchema::ValidationError => e
      #   warn 'OpenAPI doc generation failed.'
      #   Rails.logger.error e.full_message
      # end
    end
    app.reloaders << watcher
    config.to_prepare do
      puts 'prepare'
      puts watcher.updated? ? 'updated' : 'not updated'
      watcher.execute_if_updated
    end
  end
end
