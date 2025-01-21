RSpec.describe "active record test plumbing" do
  before do
    stub_class "Capybara", ActiveRecord::Base
  end

  it "creates the expected Capybara active record model and CRUD operations work" do
    capybara = Capybara.create(name: "Fumiko", age: 100)

    id = capybara.id
    expect(id).to be_an(Integer)

    capybara = Capybara.find(id)
    expect(capybara).to be_a(Capybara)

    expect(capybara.age).to be(100)
  end

  context "when using it as a foobara type" do
    before do
      Foobara::GlobalDomain.foobara_type_from_declaration(Capybara)
    end

    it "has attribute helpers" do
      expect(Capybara.foobara_attributes_for_update).to be_a(Hash)
      expect(Capybara.foobara_attributes_for_update[:element_type_declarations]).to include(:name, :age)
    end
  end
end
