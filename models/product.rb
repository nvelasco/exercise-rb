require 'active_record'
require_relative '../config/connection_params'

class Product < ActiveRecord::Base
  establish_connection(CONNECTION_PARAMS)
end
