module CommittteeRailsOpenapi2
  include Committee::Rails::Test::Methods

  def committee_schema
    @committee_schema ||=
      begin
        driver = Committee::Drivers::OpenAPI2.new
        schema_hash = JSON.parse(File.read(schema_path))
        driver.parse(schema_hash)
      end
  end

  def schema_path
    Rails.root.join('docs', 'swagger.json')
  end
end

module ProcessWithAssertSchemaConform
  include CommittteeRailsOpenapi2

  def process(*args)
    super *args
    assert_schema_conform
  end
end

class ActionDispatch::Integration::Session
  prepend ProcessWithAssertSchemaConform
end
