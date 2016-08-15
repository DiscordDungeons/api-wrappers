require 'rest-client'

require './dd-api/api.rb'
require './dd-api/classes.rb'

# Initializer Module
module DDAPI::Init
  include API

  def user(id)
    User.new(get_user(self, id), self)
  end

  def guild(id)
    Guild.new(get_guild(self, id), self)
  end
end
