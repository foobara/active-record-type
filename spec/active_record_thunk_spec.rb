RSpec.describe Foobara::ActiveRecordThunk do
  after do
    Foobara.reset_alls
  end

  before do
    stub_module "SomeDomain" do
      foobara_domain!
    end
    stub_class "SomeDomain::Capybara", ActiveRecord::Base
    type
  end

  let(:active_record_class) { SomeDomain::Capybara }
  let(:record) { SomeDomain::Capybara.create(name: "Fumiko") }
  let(:type_declaration) { active_record_class }
  let(:type) { Foobara::GlobalDomain.foobara_type_from_declaration(type_declaration) }
  let(:thunk) { described_class.new(active_record_class, record.id) }

  describe "#==" do
    it "is true for the same record" do
      expect(thunk).to eq(record)
      expect(record).to eq(thunk)
    end
  end
end
