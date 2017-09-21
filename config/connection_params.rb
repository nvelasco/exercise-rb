require 'yaml'

file = File.dirname(__FILE__) + '/database.yml'
config_databases = YAML.load_file(file)
CONNECTION_PARAMS = if ENV['ENV'] == 'test'
                      config_databases['test']
                    else
                      config_databases['default']
                    end
