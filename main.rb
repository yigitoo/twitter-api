#!/usr/bin/env ruby
require 'x'
require 'x/media_uploader'

require 'dotenv/load'

x_cred =  {
    api_key: ENV['API_KEY'],
    api_key_secret: ENV['API_KEY_SECRET'],
    access_token: ENV['ACCESS_TOKEN'],
    access_token_secret: ENV['ACCESS_TOKEN_SECRET'],
}


client = X::Client.new(**x_cred)

me = client.get('users/me')['data']
puts "Logged in as #{me['name']} (@#{me['username']})."


file_path = "ataturk.jpg"
media_category = "tweet_image"

media = X::MediaUploader.upload(client:, file_path:, media_category:)

tweet_body = {
    text: "Hello, world! I\'m Yigit. Sended via X-Ruby Gem. (@gem)" ,
    media: {
        media_ids: [media["media_id_string"]]
    }
}

tweet = client.post("tweets", tweet_body.to_json)

puts "https://x.com/#{me['username']}/status/#{tweet['data']['id']}"

