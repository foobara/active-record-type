RSpec.describe "creating a foobara :active_record type" do
  after do
    Foobara.reset_alls
  end

  before do
    stub_module "SomeDomain" do
      foobara_domain!
    end
    stub_class "SomeDomain::Capybara", ActiveRecord::Base
  end

  let(:type_declaration) { SomeDomain::Capybara }
  let(:type) { Foobara::GlobalDomain.foobara_type_from_declaration(type_declaration) }

  context "when declaring as a command input as an active record class" do
    let(:command_class) do
      stub_class "SomeDomain::SomeCommand", Foobara::Command do
        inputs do
          capybara SomeDomain::Capybara
        end
      end
    end

    it "has a simple declaration data" do
      expect(
        command_class.inputs_type.declaration_data[:element_type_declarations][:capybara]
      ).to eq(:"SomeDomain::Capybara")

      type2 = Foobara::Domain.current.foobara_type_from_declaration(SomeDomain::Capybara)
      expect(type2.target_class).to eq(SomeDomain::Capybara)
    end
  end

  context "when declaring via active record class" do
    it "creates a foobara :active_record type with the expected attributes" do
      expect(type).to be_a(Foobara::Type)
      expect(type.foobara_domain).to be(SomeDomain)
      expect(type.extends?(Foobara::BuiltinTypes[:detached_entity])).to be true
    end

    it "can cast a primary key to an active record" do
      capybara = SomeDomain::Capybara.create(name: "Fumiko", age: 100)

      id = capybara.id
      expect(id).to be_an(Integer)

      cast_capybara = type.process_value!(id)

      expect(cast_capybara).to be_a(SomeDomain::Capybara)
      expect(cast_capybara.age).to be(100)
      expect(cast_capybara.id).to be(id)
      expect(cast_capybara).to respond_to(:age)
    end

    context "when its a subclass of an active record class" do
      let(:type_declaration) { SomeDomain::CapybaraSubclass }

      before do
        stub_class "SomeDomain::CapybaraSubclass", SomeDomain::Capybara
      end

      it "can function with subclasses" do
        capybara = SomeDomain::CapybaraSubclass.create(name: "Fumiko", age: 100)

        id = capybara.id
        expect(id).to be_an(Integer)

        cast_capybara = type.process_value!(id)

        expect(cast_capybara).to be_a(SomeDomain::CapybaraSubclass)
        expect(cast_capybara.age).to be(100)
        expect(cast_capybara.id).to be(id)
        expect(cast_capybara).to respond_to(:age)
      end
    end

    context "when already registered" do
      it "returns the already-registered type" do
        new_type = Foobara::GlobalDomain.foobara_type_from_declaration(type.target_class)
        expect(new_type).to be(SomeDomain::Capybara.foobara_type)
      end
    end
  end

  context "when declaring via strict type declaration" do
    let(:type_declaration) do
      {
        type: :active_record,
        model_class: "SomeDomain::Capybara",
        name: "SomeDomain::Capybara",
        model_base_class: "ActiveRecord::Base",
        model_module: "SomeDomain",
        primary_key: :id,
        attributes_declaration: {
          type: :attributes,
          element_type_declarations: {
            id: { type: :integer },
            name: { type: :string },
            nickname: { type: :string, allow_nil: true },
            age: { type: :integer, allow_nil: true },
            created_at: { type: :datetime },
            updated_at: { type: :datetime }
          },
          defaults: {},
          required: [:id, :name, :created_at, :updated_at]
        }
      }
    end

    it "can cast a primary key to an active record" do
      expect(type.extends?(:active_record)).to be true

      capybara = SomeDomain::Capybara.create(name: "Fumiko", age: 100)

      id = capybara.id
      expect(id).to be_an(Integer)

      cast_capybara = type.process_value!(id)

      expect(cast_capybara).to be_a(SomeDomain::Capybara)
      expect(cast_capybara.age).to be(100)
      expect(cast_capybara.id).to be(id)
      expect(cast_capybara).to respond_to(:age)

      expect(cast_capybara).to respond_to(:foobara_active_record_class)
      expect(cast_capybara).to respond_to(:foobara_primary_key_attribute)
      expect(cast_capybara).to respond_to(:foobara_primary_key)
      expect(cast_capybara).to_not respond_to(:foobara_load_if_needed)
      expect(cast_capybara.respond_to?(:foobara_load_if_needed, true)).to be true
      expect(cast_capybara.foobara_active_record_class).to be(SomeDomain::Capybara)
      expect(cast_capybara.foobara_primary_key_attribute).to eq(:id)
      expect(cast_capybara.foobara_primary_key).to eq(id)
    end

    it "can cast from a hash of attributes" do
      expect(type.extends?(:active_record)).to be true

      cast_capybara = type.process_value!(name: "Fumiko", age: 100)

      expect(cast_capybara).to be_a(SomeDomain::Capybara)
      expect(cast_capybara.age).to be(100)
      expect(cast_capybara.id).to be_nil
      expect(cast_capybara).to be_new_record
    end
  end

  context "when processing a bad value" do
    it "raises an error" do
      expect { type.process_value!("asdf") }.to raise_error(Foobara::Value::Processor::Casting::CannotCastError)
    end
  end
end
