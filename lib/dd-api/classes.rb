require 'json'
require 'htmlentities'

require './dd-api/api.rb'
require './dd-api/init.rb'

# Objects essential to DRPG
module DDAPI
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
    alias_method :lvl, :level

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
  class Guild
    # @return [String] The name of the guild.
    attr_accessor :name

    # @return [User] The user object of the guild owner.
    attr_accessor :owner
    alias_method :leader, :owner

    # @return [String] The description of the guild.
    attr_accessor :description
    alias_method :desc, :description

    # @return [Integer] The amount gold in the guild.
    attr_accessor :gold

    # @return [Integer] The level at that time, of the guild.
    attr_accessor :level
    alias_method :lvl, :level

    # @return [Integer] The ID of the user.
    attr_accessor :id

    # @return [true, false] The icon of the guild.
    attr_accessor :icon

    def initialize(data, app)
      @data = data
      @name = data['name']
      @level = data['level']
      @description = data['desc']
      @gold = data['gold']
      @icon = HTMLEntities.new.decode(data['icon'])
      @id = data['id']
      @members = data['members']
      @owner = @app.user(data['owner'])
      @app = app
    end

    # The inspect method is overwritten to give more useful output
    def inspect
      "#<DDAPI::Guild name=#{@name} id=#{@id} level=#{@level}>"
    end
  end
end
