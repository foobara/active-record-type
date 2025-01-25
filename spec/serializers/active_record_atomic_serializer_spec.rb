RSpec.describe Foobara::CommandConnectors::Serializers::ActiveRecordAtomicSerializer do
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

  let(:record) { SomeDomain::Capybara.create(name: "Fumiko", age: 100) }
  let(:serializer) { described_class.new }

  describe "#serialize" do
    let(:result) { serializer.serialize(record) }

    it "serializes the record" do
      expect(result["name"]).to eq("Fumiko")
      expect(result["age"]).to eq(100)
    end

    context "when it's not an active record" do
      let(:record) { 1 }

      it "serializes the data" do
        expect(result).to eq(1)
      end
    end
  end
end
