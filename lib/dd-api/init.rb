require 'rest-client'

require './dd-api/api.rb'
require './dd-api/classes.rb'

module DDAPI
  # Initializer Module
  module Init
    include API

    # def users
      # all_users(self).values.map { |guild| User.new(guild, self) }
    # end

    def guilds
      all_guilds(self).values.map { |guild| Guild.new(guild, self) }
    end

    def user(id)
      User.new(get_user(self, id), self)
    end

    def guild(id)
      Guild.new(get_guild(self, id), self)
    end
  end
end
