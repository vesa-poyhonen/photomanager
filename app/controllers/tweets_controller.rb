require 'oauth2'
require 'net/http'
require 'json'

class TweetsController < ApplicationController
  def oauth_request
    client = OAuth2::Client.new(
        ENV['OAUTH_CLIENT_ID'],
        ENV['OAUTH_CLIENT_SECRET'],
        site: ENV['OAUTH_SITE'] + '/oauth/authorize')

    redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth/callback')
  end

  def oauth_callback
    client = OAuth2::Client.new(
        ENV['OAUTH_CLIENT_ID'],
        ENV['OAUTH_CLIENT_SECRET'],
        site: ENV['OAUTH_SITE'] + '/oauth/token')

    response = client.auth_code.get_token(params['code'], :redirect_uri => 'http://localhost:3000/oauth/callback')
    session[:access_token] = response.token

    redirect_to pictures_path
  end

  def submit
    picture = Picture.where(id: params[:id], user: current_user).first
    return redirect_to pictures_path if picture.nil?

    begin
      uri = URI('https://arcane-ravine-29792.herokuapp.com/api/tweets')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(
          uri.path,
          {
              'Content-Type' => 'application/json',
              'Authorization' => "Bearer #{session[:access_token]}"
          })
      request.body = {
          text: picture.title,
          url: 'http://localhost:3000/uploads/' + picture.filename
      }.to_json

      response = http.request(request)

      if response.code.to_i == 201
        flash['success'] = 'You tweeted successfully picture with ' + picture.title.to_s + ' as a title'
      else
        flash['danger'] = 'Tweeting this picture failed. Please try again.'
      end
    rescue => e
      flash['danger'] = 'Tweeting this picture failed. Please try again.'
      puts e
    end

    redirect_to pictures_path
  end
end