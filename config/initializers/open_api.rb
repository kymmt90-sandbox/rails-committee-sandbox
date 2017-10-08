require 'filewatcher'

Filewatcher.new(Rails.root.join('docs', 'swagger.json')).watch do |filename, event|
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
