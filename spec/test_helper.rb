ENV['ENV'] = 'test'

require 'active_record'
require_relative '../config/connection_params'

# delete the database file if it exists
if File.exist?(CONNECTION_PARAMS['database'])
  File.delete(CONNECTION_PARAMS['database'])
end

ActiveRecord::Base.establish_connection CONNECTION_PARAMS
ActiveRecord::Tasks::DatabaseTasks.load_schema(CONNECTION_PARAMS,
                                               :ruby,
                                               'spec/db/schema.rb')
