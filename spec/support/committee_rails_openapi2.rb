module CommittteeRailsOpenapi2
  include Committee::Rails::Test::Methods

  def committee_schema
    @committee_schema ||=
      begin
        driver = Committee::Drivers::OpenAPI2.new
        schema_hash = JSON.parse(File.read(Rails.root.join('docs', 'swagger.json')))
        driver.parse(schema_hash)
      end
  end
end
