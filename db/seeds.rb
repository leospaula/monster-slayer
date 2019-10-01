require 'active_record'

model_dir = 'lib/models'
require_pattern = File.join(model_dir, '*.rb')

Dir.glob(require_pattern).each do |f|
  require_relative File.join('..', f)
end

def db_configuration
  db_configuration_file = File.join(File.expand_path('..', __FILE__), 'config.yml')
  YAML.load(File.read(db_configuration_file))
end

ActiveRecord::Base.establish_connection(db_configuration["development"])

Model::Monster.find_or_create_by(name: 'Imp')
Model::Monster.find_or_create_by(name: 'Winged Imp')

p "Monsters : #{Model::Monster.all.inspect}"