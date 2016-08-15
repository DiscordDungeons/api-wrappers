[![Gem Version](https://img.shields.io/gem/v/dd-api.svg)]()
[![Gem Downloads](https://img.shields.io/gem/dt/dd-api.svg)]() [![Travis](https://img.shields.io/travis/DiscordDungeons/api-rb/master.svg)]()
[![Join Discord](https://img.shields.io/badge/discord-join-7289DA.svg)](http://discord.discorddungeons.me)
-----
### A wrapper gem to the [Discord Dungeons API](http://api.discorddungeons.me/docs)
To start, make a new module using your [API Key and User Agent.](http://api.discorddungeons.me/docs#api-key)
```ruby
app = DDAPI::app.new('api-key', 'user-agent')
```
You can search for users, items, guild items and guilds.
```ruby
app.find_user('Kurosaki')
app.find_item('Salt')
app.find_guild_item('Guild Tag')
app.find_guild('Discord Dungeons')
```
You can also use IDs to get various things.
```ruby
app.user('user_id')
app.item(93)
app.guild_item(4)
app.guild('f-c-d-e')
app.mob(8)
```

And also, you can get a array of all items, guild items, and users.
```ruby
app.users
app.items
app.guild_items
app.guilds
app.mobs
```

For support, [visit the discord server](http://discord.discorddungeons.me)
