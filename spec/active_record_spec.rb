RSpec.describe "active record test plumbing" do
  before do
    stub_module "SomeDomain" do
      foobara_domain!
    end
    stub_class "SomeDomain::Capybara", ActiveRecord::Base

    Foobara::GlobalDomain.foobara_type_from_declaration(SomeDomain::Capybara)
  end

  after do
    Foobara.reset_alls
  end

  it "creates the expected SomeDomain::Capybara active record model and CRUD operations work" do
    capybara = SomeDomain::Capybara.create(name: "Fumiko", age: 100)

    id = capybara.id
    expect(id).to be_an(Integer)

    capybara = SomeDomain::Capybara.find(id)
    expect(capybara).to be_a(SomeDomain::Capybara)

    expect(capybara.age).to be(100)
  end

  it "has attribute helpers" do
    [
      :foobara_attributes_for_create,
      :foobara_attributes_for_update,
      :foobara_attributes_for_atom_update,
      :foobara_attributes_for_find_by
    ].each do |method|
      declaration = SomeDomain::Capybara.send(method)
      expect(declaration[:element_type_declarations]).to include(:name, :age)
    end
  end

  it "has a foobara_primary_key_type" do
    expect(SomeDomain::Capybara.foobara_primary_key_type).to be(Foobara::BuiltinTypes[:integer])
  end

  it "is properly scoped" do
    expect(SomeDomain::Capybara.foobara_type.scoped_full_name).to eq("SomeDomain::Capybara")
    expect(SomeDomain::Capybara.foobara_type.declaration_data[:name]).to eq("Capybara")
    expect(SomeDomain::Capybara.foobara_type.foobara_manifest.key?(:attributes_type)).to be true
  end
end
