require 'rest-client'

require 'dd-api/errors'

# List of methods representing endpoints in Discord Dungeons's API
module DDAPI
  module API
    # Make an item image URL from the item image
    def self.item_url(image)
      "https://res.discorddungeons.me/images/"+image
    end

    def self.rget(endpoint, api_key, user_agent)
      JSON.parse(RestClient.get("http://api.discorddungeons.me/"+endpoint, :'X-Api-Key' => api_key, :'User-Agent' => user_agent))
    end

    def self.get(endpoint, app)
      JSON.parse(RestClient.get("http://api.discorddungeons.me/"+endpoint, :'X-Api-Key' => app.api_key, :'User-Agent' => app.user_agent))
    end

    def self.get_user(app, id)
      get('user/'+id.to_s, app)['user']
    end

    def self.get_guild(app, id)
      get('guild/'+id, app)['data']
    end

    def self.get_items(app, id)
      get('item/'+id, app)['data']
    end

    def self.get_gitems(app, id)
      get('gitem/'+id, app)['data']
    end

    def self.all_guilds(app)
      get('all/guilds', app)['data']
    end

    def self.all_users(app)
      get('all/users', app)['data']
    end

    def self.all_items(app)
      get('all/items', app)['data']
    end

    def self.all_gitems(app)
      get('all/gitems', app)['data']
    end
  end
end
