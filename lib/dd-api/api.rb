require 'rest-client'

require './dd-api/errors.rb'

# List of methods representing endpoints in Discord Dungeons's API
module DDAPI::API
  def rget(endpoint, api_key, user_agent)
    JSON.parse(RestClient.get("http://api.discorddungeons.me/"+endpoint, :'X-Api-Key' => api_key, :'User-Agent' => user_agent))
  end

  def get(endpoint, app)
    JSON.parse(RestClient.get("http://api.discorddungeons.me/"+endpoint, :'X-Api-Key' => app.api_key, :'User-Agent' => app.user_agent))
  end

  def get_user(app, id)
    get('user/'+id.to_s, app)['user']
  end

  def get_guild(app, id)
    get('guild/'+id, app)['data']
  end
end
