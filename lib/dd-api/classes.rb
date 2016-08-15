require 'json'
require 'htmlentities'

require './dd-api/api.rb'

# Objects essential to DRPG
module DDAPI
  class App
    include Init

    # @return [Hash] The api key of the instance.
    attr_accessor :api_key

    # @return [Srting] The user agent of the instance.
    attr_accessor :user_agent

    def initialize(api_key, user_agent)
        @api_key = api_key
        @user_agent = user_agent
    end

    # # The full list of Devices.
    # # @return [Hash] Array of devices available.
    # def guilds
        # respond = []
        # API.get("all/guilds", @api_key, @user_agent)["data"].each {|d| respond.push(Guild.new(d, @api_key, @user_agent))}
        # respond
    # end
  end
  class User
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

    # @return [Hash] Raw JSON data of the user.
    attr_accessor :data

    # @return [Srting] The name of the user.
    attr_accessor :name
    alias_method :nickname, :name

    # @return [Fixnum] How much health that user has
    attr_accessor :hp
    alias_method :health, :hp

    # @return [Fixnum] How much deaths that user has
    attr_accessor :deaths
    alias_method :frags, :deaths

    # @return [Fixnum] How much kills that user has
    attr_accessor :kills

    # @return [Fixnum] How much gold that user has
    attr_accessor :gold

    # @return [Fixnum] How much experience that user has
    attr_accessor :xp
    alias_method :experience, :xp

    # @return [Fixnum] The level at that time, of the user.
    attr_accessor :level
    alias_method :lvl, :level

    # @return [Fixnum] How much maximun health that user has
    attr_accessor :max_hp
    alias_method :max_health, :max_hp

    # @return [Fixnum] The ID of the user.
    attr_accessor :id

    # @return [true, false] whether the user donated to Discord Dungeons or not.
    attr_accessor :donated
    alias_method :donated?, :donated

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
    def initialize(data, app)
      @data = data
      @name = data['name']
      @level = data['level']
      @description = data['desc']
      @gold = data['gold']
      @icon = HTMLEntities.new.decode(data['icon'])
      @id = data['id']
      @members = data['members']
      @gold = data['owner']
      @app = app
    end

    # @return [Hash] Raw JSON data of the user.
    attr_accessor :data

    # @return [Srting] The name of the guild.
    attr_accessor :name

    # @return [Srting] The description of the guild.
    attr_accessor :description
    alias_method :desc, :description

    # @return [Fixnum] The amount gold at that time, in the guild the guild.
    attr_accessor :gold

    # @return [Fixnum] The level at that time, of the guild.
    attr_accessor :level
    alias_method :lvl, :level

    # @return [Fixnum] The ID of the user.
    attr_accessor :id

    # @return [true, false] The icon of the guild.
    attr_accessor :icon

    # @return [User] The user object of the guild owner.
    def owner
      @app.user(@owner)
    end

    # The inspect method is overwritten to give more useful output
    def inspect
      "#<DDAPI::Guild name=#{@name} id=#{@id} level=#{@level}>"
    end
  end
end
