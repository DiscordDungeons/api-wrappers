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

    def guild_items
      API.all_guild_items(self).values.map { |gitem| GuildItem.new(gitem, self) }
    end

    def user(id)
      User.new(API.get_user(self, id), self)
    end

    def guild(id)
      Guild.new(API.get_guild(self, id), self)
    end

    def item(id)
      Item.new(API.get_item(self, id), self)
    end

    def guild_item(id)
      Item.new(API.get_guild_item(self, id), self)
    end
  end
end
