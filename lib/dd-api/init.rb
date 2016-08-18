require 'rest-client'

require 'dd-api/api'
require 'dd-api/classes'

module DDAPI
  # Initializer Module
  module Init

    # def users
      # all_users(self).values.map { |guild| User.new(guild, self) }
    # end

    def guilds
      API.all_guilds(self).values.map { |guild| Guild.new(guild, self) }
    end

    def items
      API.all_items(self).values.map { |item| Item.new(item, self) }
    end

    def gitems
      API.all_gitems(self).values.map { |gitem| GuildItem.new(gitem, self) }
    end

    def user(id)
      User.new(API.get_user(self, id), self)
    end

    def guild(id)
      Guild.new(API.get_guild(self, id), self)
    end
  end
end
