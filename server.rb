module Perdito
  class Server < Sinatra::Base

    enable :logging

    configure :development do
      register Sinatra::Reloader
      $redis = Redis.new
    end


    get('/') do
      #redirect to('/stories')
      render(:erb, :index, :layout => :default)
    end

    get('/stories') do
      #@mumbles = mumbles.sort_by {|mumble| mumble["date"]}

    end

    get('/stories/new') do
      render(:erb, :new, :layout => :default)
    end

    get('/stories/:id') do
      @mumble = mumble(params[:id])
      render(:erb, :show, :layout => :default)
    end

    post('/stories') do
      if params['text'] == '' || params['author_email'] == ''
        redirect to('/mumbles/new')
      end
    end



  end #Class
end #Perdito
