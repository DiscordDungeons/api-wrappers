![DD API](https://raw.githubusercontent.com/DiscordDungeons/api-rb/master/image.jpeg)
[![Gem Version](https://img.shields.io/gem/v/dd-api.svg)]()
[![Gem Downloads](https://img.shields.io/gem/dt/dd-api.svg)]() [![Travis](https://img.shields.io/travis/DiscordDungeons/api-rb/master.svg)]()
[![Join Discord](https://img.shields.io/badge/discord-join-7289DA.svg)](http://discord.discorddungeons.me)
-----
### A wrapper gem to the [Discord Dungeons API](http://api.discorddungeons.me/docs)
To start, make a new module using your [API Key and User Agent.](http://api.discorddungeons.me/docs#api-key)
```ruby
api = DDAPI.new('api-key', 'user-agent')
```
You can search for users, items, guild items and guilds.
```ruby
api.find_user('Kurosaki')
api.find_item('Salt')
api.find_guild_item('Guild Tag')
api.find_guild('Discord Dungeons')
```
You can also use IDs to get various things.
```ruby
api.get_user('user_id')
api.get_item(93)
api.get_guild_item(4)
api.get_guild('f-c-d-e')
api.get_mob(8)
```

And also, you can get a array of all items, guild items, and users.
```ruby
api.users
api.items
api.guild_items
api.guilds
api.mobs
```

For support, [visit the discord server](http://discord.discorddungeons.me)
