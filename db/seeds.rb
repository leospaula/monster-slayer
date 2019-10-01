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

Model::Trophy.find_or_create_by(name: 'Bronze', image: 'bronze_trophy.png')
Model::Trophy.find_or_create_by(name: 'Silver', image: 'silver_trophy.png')
Model::Trophy.find_or_create_by(name: 'Gold', image: 'gold_trophy.png')
Model::Trophy.find_or_create_by(name: 'Platinum', image: 'platinum_trophy.png')
Model::Trophy.find_or_create_by(name: 'Diamond', image: 'diamond_trophy.png')

goal_values = {
  'monster': { desc: 'Monstros', init: 10, step: 5 },
  'coin': { desc: 'Moedas', init: 100, step: 100 },
  'death': { desc: 'Mortes', init: 2, step: 3 }
}

goal_values.each do |key, value|
  goal_value = value[:init]
  Model::Trophy.all.each do |trophy|
    Model::Goal.find_or_create_by(
      trophy_id: trophy.id,
      description: "#{goal_value} #{value[:desc]}",
      category: key,
      value: goal_value
    )

    goal_value += value[:step]
  end
end
