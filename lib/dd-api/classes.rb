require 'json'
require 'htmlentities'

require 'dd-api/init'

# Objects essential to DRPG
module DDAPI
  # A Class that is bundled with an API key and a User Agent. Base of gem.
  class App
    # @return [String] The api key of the instance.
    attr_accessor :api_key

    # @return [String] The user agent of the instance.
    attr_accessor :user_agent

    include Init

    def initialize(api_key, user_agent)
        @api_key = api_key
        @user_agent = user_agent
    end
  end
  # Represents a DRPG user.
  class User
    # @return [Srting] The name of the user.
    attr_accessor :name
    alias_method :nickname, :name

    # @return [Integer] How much health that user has
    attr_accessor :hp
    alias_method :health, :hp

    # @return [Integer] How much deaths that user has
    attr_accessor :deaths
    alias_method :frags, :deaths

    # @return [Integer] How much kills that user has
    attr_accessor :kills

    # @return [Integer] How much gold that user has
    attr_accessor :gold

    # @return [Integer] How much experience that user has
    attr_accessor :xp
    alias_method :experience, :xp

    # @return [Integer] The level at that time, of the user.
    attr_accessor :level

    # @return [Integer] How much maximun health that user has
    attr_accessor :max_hp
    alias_method :max_health, :max_hp

    # @return [Integer] The ID of the user.
    attr_accessor :id

    # @return [true, false] whether the user donated to Discord Dungeons or not.
    attr_accessor :donated
    alias_method :donated?, :donated

    def initialize(data, app)
      @data = data['data']
      @id = data['id']
      @name = @data['name']
      @level = @data['level']
      @hp = @data['hp']
      @max_hp = @data['maxhp']
      @gold = @data['gold']
      @xp = @data['xp']
      @kills = @data['kills']
      @deaths = @data['deaths']
      @weapon_id = @data['weapon']
      @donated = @data['donate']
      @guild = @data['guild']
      @app = app
    end

    # @return [Guild, nil] the user's guild
    def guild
      if @guild != ""
        @app.guild(@guild)
      else
        nil
      end
    end

    # The inspect method is overwritten to give more useful output
    def inspect
      "#<DDAPI::User name=#{@name} id=#{@id} level=#{@level}>"
    end
  end
  # Represents a DRPG guild.
  class Guild
    # @return [String] The name of the guild.
    attr_accessor :name

    # @return [User] The user object of the guild owner.
    attr_accessor :owner
    alias_method :leader, :owner

    # @return [String] The description of the guild.
    attr_accessor :description
    alias_method :desc, :description

    # @return [true, false] Whether the guild is open.
    attr_accessor :open

    # @return [Integer] The amount gold in the guild.
    attr_accessor :gold

    # @return [Integer] The combined deaths by the guild members.
    attr_accessor :deaths
    alias_method :frags, :deaths

    # @return [Integer] The combined enemies slain by the guild members.
    attr_accessor :kills
    alias_method :slain, :kills

    # @return [Integer] The maximum amount of people that can be in the guild.
    attr_accessor :max

    # @return [Integer] The level of the guild.
    attr_accessor :level

    # @return [Integer] The ID of the guild.
    attr_accessor :id

    # @return [Integer] The level requirement of the guild.
    attr_accessor :level_requirement

    # @return [String] The icon of the guild.
    attr_accessor :icon

    # @return [String] The icon image URL to the guild's icon.
    attr_accessor :image

    # @return [Array<String>] Array of icons the guild has bought.
    attr_accessor :icons

    # @return [String, nil] The Discord Role ID of the guild. `nil` if there is no role.
    attr_accessor :role

    # @return [String, nil] The Discord Channel ID of the guild. `nil` if there is no channel.
    attr_accessor :channel

    def initialize(data, app)
      @data = data
      # gdata = data['guild']
      gdata = data
      @name = data['name']
      @open = data['open']
      @level = gdata['level']
      @description = gdata['desc']
      @gold = gdata['gold']
      @kills = @data['slain']
      @deaths = @data['deaths']
      @icon = HTMLEntities.new.decode(gdata['icon'])
      @icon_url = API.guild_icon_url(gdata['icon'])
      @icons = gdata['icons'].map {|icon| HTMLEntities.new.decode(icon) }
      @id = data['id']
      @members = gdata['members']
      @level_requirement = gdata['levelreq']
      @max = gdata['max']
      @owner = @app.user(gdata['owner'])
      @role = gdata['role'].empty? ? nil : gdata['role']
      @channel = gdata['channel'].empty? ? nil : gdata['channel']
      @app = app
    end

    # The inspect method is overwritten to give more useful output
    def inspect
      "#<DDAPI::Guild name=#{@name} id=#{@id} level=#{@level}>"
    end
  end
  # Represents a DRPG item.
  class Item
    # @return [String] The name of the item.
    attr_accessor :name

    # @return [Integer, nil] The cost of the item. `nil` if not buyable.
    attr_accessor :sell_price

    # @return [String] The prefix name of the item.
    attr_accessor :prefix

    # @return [String] The plural name of the item.
    attr_accessor :plural

    # @return [String] The type of the item.
    attr_accessor :type

    # @return [String] The description of the item.
    attr_accessor :description
    alias_method :desc, :description

    # @return [String] The image URL to the item. `nil` if there is no image.
    attr_accessor :image

    # @return [Integer] The level of the item.
    attr_accessor :level

    # @return [Integer] The ID of the item.
    # attr_accessor :id

    # @return [true, false] Whether the item is sellable.
    attr_accessor :sellable

    # @return [Integer, nil] The sell price of the item. `nil` if not sellable.
    attr_accessor :sell_price

    # @return [true, false] Whether the item is tradeable.
    attr_accessor :tradeable

    def initialize(data, app)
      @data = data
      @name = data['name']
      @level = data['level']
      @description = data['desc']
      @type = data['type']
      @image = data['image'].nil? ? nil : API.image_url(data['image'])
      #@id = data['id']
      @prefix = data['prefix']
      @prefix = data['plural']
      @sellable = data['sellable']
      @tradeable = data['tradeable']
      @sell_price = data['sell'] == -1 ? nil : data['sell']
      @cost = data['cost'] == -1 ? nil : data['cost']
      @app = app
    end

    # The inspect method is overwritten to give more useful output
    def inspect
      "#<DDAPI::Item name=#{@name} id=#{@id} level=#{@level}>"
    end
  end
  # Represents a DRPG guild item.
  class GuildItem
    # @return [String] The name of the item.
    attr_accessor :name

    # @return [Integer, nil] The cost of the item. `nil` if not buyable.
    attr_accessor :sell_price

    # @return [String] The prefix name of the item.
    attr_accessor :prefix

    # @return [String] The plural name of the item.
    attr_accessor :plural

    # @return [String] The description of the item.
    attr_accessor :description
    alias_method :desc, :description

    # @return [String, nil] The image URL to the item. `nil` if there is no image.
    attr_accessor :image

    # @return [Integer] The level of the item.
    attr_accessor :level

    # @return [Integer] The ID of the item.
    # attr_accessor :id

    def initialize(data, app)
      @data = data
      @name = data['name']
      @level = data['level']
      @description = data['desc']
      @image = data['image'].nil? ? nil : API.image_url(data['image'])
      #@id = data['id']
      @prefix = data['prefix']
      @prefix = data['plural']
      @cost = data['cost'] == -1 ? nil : data['cost']
      @app = app
    end

    # The inspect method is overwritten to give more useful output
    def inspect
      "#<DDAPI::GuildItem name=#{@name} id=#{@id} level=#{@level}>"
    end
  end
end
