# app.rb
require 'sinatra'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'rack/mobile-detect'
require 'sinatra/cross_origin'
use Rack::MobileDetect
register Sinatra::CrossOrigin

configure do
  I18n.config.available_locales = [:en, :kr, :es, :jp, :cn, :pt]
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
  I18n.backend.load_translations
  I18n.default_locale = :en

  enable :cross_origin
end

before '/:locale/*' do
  @locale           = params[:locale]
  I18n.locale       = params[:locale]
  request.path_info = '/' + params[:splat ][0]
end

#включаем сессии - они в Sinatra по умолчанию выключены
#сессия нам нужна для сохранения в ней данных первого захода:
#POST-параметры с которыми зашел на сайт юзер
enable :sessions

before do
  response.headers["Allow"] = "GET, POST, OPTIONS"
  response.headers["Access-Control-Allow-Methods"] = "HEAD, GET, OPTIONS"
  response.headers["Access-Control-Expose-Headers"] = "Content-Range, Date, Etag, X-Cache"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type, Origin, Accept, Range, Cache-Control"
  response.headers["Access-Control-Request-Headers"] = "Content-Type, Origin, Accept, Range, Cache-Control"
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["AAccess-Control-Max-Age"] = "600"
  response.headers["Timing-Allow-Origin"] = "*"
end


get '/' do
  @mobile_device = ( request.env['X_MOBILE_DEVICE'] ? true : false )
  I18n.locale = :en if @locale == nil
  haml :index
  # puts session
  # ver = session[:ver]
  # puts "Hello, #{ver}!"

  # puts "VERVERVER=#{session[:ver]}"
  # if session[:ver]=="mobile"
  #   haml :index, :locals => {:styles => "index_mobile.css", :test => session[:ver]}
  # else
  #   haml :index, :locals => {:styles => "index.css", :test => session[:ver]}
  # end
end

get '/how_it_works' do
  haml :how_it_works
end

get '/eiratech-robotics-are-trying-to-inflict-on-eiraCube' do
  @mobile_device = ( request.env['X_MOBILE_DEVICE'] ? true : false )
  haml :eiratech_robotics_are_trying_to_inflict_on_eiracube
end

get '/eiratech-robotics-are-trying-to-inflict-on-eiracube' do
  @mobile_device = ( request.env['X_MOBILE_DEVICE'] ? true : false )
  haml :eiratech_robotics_are_trying_to_inflict_on_eiracube
end

options "*" do
  response.headers["Allow"] = "GET, POST, OPTIONS"
  response.headers["Access-Control-Allow-Methods"] = "HEAD, GET, OPTIONS"
  response.headers["Access-Control-Expose-Headers"] = "Content-Range, Date, Etag, X-Cache"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type, Origin, Accept, Range, Cache-Control"
  response.headers["Access-Control-Request-Headers"] = "Content-Type, Origin, Accept, Range, Cache-Control"
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["AAccess-Control-Max-Age"] = "600"
  response.headers["Timing-Allow-Origin"] = "*"
  200
end