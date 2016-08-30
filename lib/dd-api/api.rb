require 'rest-client'

require 'dd-api/errors'

# List of methods representing endpoints in Discord Dungeons's API
module DDAPI::API
  # The base URL of the Discord Dungeons REST API.
  APIBASE = 'http://api.discorddungeons.me'.freeze

  # The base URL of the Discord Dungeons Alternate Resources.
  RESBASE = 'https://res.discorddungeons.me/images'.freeze

  module_function

  # @return [String] the currently used API base URL.
  def api_base
    APIBASE
  end

  # @return [String] the currently used resource base URL.
  def res_base
    RESBASE
  end

  # Make an item image URL from the item image
  def image_url(image)
    "#{res_base}/#{image}"
  end
  # Make an item image URL from the item image
  def guild_icon_url(icon)
    "#{res_base}/twemoji/"+icon.gsub(/\u0026#x/, "").gsub(/[;]/, "").gsub(/\u0026amp/, "-").downcase+".png"
  end

  def rget(endpoint, api_key, user_agent)
    JSON.parse(RestClient.get("#{api_base}/"+endpoint, :'X-Api-Key' => api_key, :'User-Agent' => user_agent))
  end

  def get(endpoint, app)
    JSON.parse(RestClient.get("#{api_base}/"+endpoint, :'X-Api-Key' => app.api_key, :'User-Agent' => app.user_agent))
  end

  def get_user(app, id)
    get('user/'+id.to_s, app)['user']
  end

  def get_guild(app, id)
    get('guild/'+id, app)['data']
  end

  def get_item(app, id)
    get('item/'+id, app)['data']
  end

  def get_guild_item(app, id)
    get('gitem/'+id, app)['data']
  end

  def all_guilds(app)
    get('all/guilds', app)['data']
  end

  def all_users(app)
    get('all/users', app)['data']
  end

  def all_items(app)
    get('all/items', app)['data']
  end

  def all_guild_items(app)
    get('all/gitems', app)['data']
  end
end
