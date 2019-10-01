#!/usr/bin/env ruby

require 'gosu'
require 'rmagick'
require 'gosu_texture_packer'
require 'active_record'

root_dir = File.dirname(__FILE__)
require_pattern = File.join(root_dir, '**/*.rb')
@failed = []

Dir.glob(require_pattern).each do |f|
  next if f.end_with?('/main.rb')
  begin
    require_relative f.gsub("#{root_dir}/", '')
  rescue
    @failed << f
  end
end

@failed.each do |f|
  require_relative f.gsub("#{root_dir}/", '')
end

def db_configuration
  db_configuration_file = File.join(File.expand_path('..', __FILE__), '..', 'db', 'config.yml')
  YAML.load(File.read(db_configuration_file))
end

ActiveRecord::Base.establish_connection(db_configuration["development"])

$window = GameWindow.new
GameState.switch(MenuState.instance)
$window.show
