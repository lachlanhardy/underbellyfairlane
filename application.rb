require 'sinatra/base'
require 'haml'
# require 'smoke'
require 'pp'
require 'lib/rack/trailingslash'
require 'lib/rack/catch_redirect'

module Application
  enable :sessions
  set :haml, {:format => :html5, :attr_wrapper => '"'}
  # set :environment => 'production' # for testing minification etc
  set :options, {
    :run => false,
    :env => ENV['RACK_ENV'] ? ENV["RACK_ENV"].to_sym : "development",
    :raise_errors => true
  }


  use Rack::Session::Cookie
  use TrailingSlash
  use Rack::CatchRedirect

  class App < Sinatra::Application
    Dir.glob("lib/helpers/*").each do |helper|
      require "#{File.dirname(__FILE__)}/#{helper}"
    end

    helpers do
      include ::Application::Helpers
    end

    before do
      mobile_request? ? @mobile = ".mobile" : @mobile = ""
    end

    error do
      handle_fail
    end

    not_found do
      handle_fail
    end

    # homepage
    get '/' do
      
      deliver :index
    end

    get '/:page/' do
      deliver :"#{params[:page]}"
    end
  end
end
