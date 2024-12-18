require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

task :environment do
  require_relative "boot"
end

# this code originally taken from: https://www.billy-ruffian.co.uk/activerecord-without-rails/
require "bundler/setup"
Bundler.require
require "json"
require "yaml"
require "active_record"

namespace :db do
  db_config = YAML.load(File.open("config/database.yml"))

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config)
    puts "Database created"
  end

  desc "Migrate the database"
  task migrate: :create do
    ActiveRecord::Base.establish_connection(db_config)
    require "pry"
    require "pry-byebug"
    # migration_context = ActiveRecord::MigrationContext.new("db/migrate/", ActiveRecord::SchemaMigration)
    # migration_context.migrate

    #    migrations = ActiveRecord::Migration.new.migration_context.migrations

    # ActiveRecord::Migrator.new(:up, migrations, nil).migrate

    # ActiveRecord::MigrationContext.new(["db/migrate/"], ActiveRecord::Base.connection.schema_migration).migrate
    ActiveRecord::MigrationContext.new(["db/migrate/"], nil).migrate

    puts "Database migrated"
  end

  desc "Drop the database"
  task :drop do
    File.delete(db_config["database"])
    puts "Database deleted"
  end

  desc "Reset the database"
  task reset: %i[drop create migrate]

  desc "Create a db/schema.rb file"
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require "active_record/schema_dumper"
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
    puts "Schema dumped"
  end

  desc "Populate the database"
  task seed: :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    load "db/seed.rb" if File.exist?("db/seed.rb")
  end
end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.write(path, <<~HERE)
      class #{migration_class} < ActiveRecord::Migration[6.0]
        def change
        end
      end
    HERE

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
