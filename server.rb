module Perdito
  class Server < Sinatra::Base

    enable :logging
    enable :sessions

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
      # binding.pry
      puts session.to_hash
      if session[:error_message]
        @error_message = session.delete(:error_message)
      end
      render(:erb, :new, :layout => :default)
    end

    get('/stories/:id') do

      render(:erb, :show, :layout => :default)
    end

    post('/stories') do
      # check for empty values
      if params['corner']      == '' ||
         params['location']    == '' ||
         params['picture']     == '' ||
         params['description'] == '' ||
         params['links']       == ''
        # there was an empty value, so failed
        # put an error message in the session
        # and go back to the form
        session[:error_message] = "Fill in all the fields!"
        puts "ERROR"
        redirect to('/stories/new')
      else
        # all information is here!
        # so, create a new story in the database
        # and go to that story's page
        id = $redis.incr("story_id")

           $redis.hmset(
           "story:#{id}",
           'corner',      params['corner'],
           'location',    params['location'],
           'picture',     params['picture'],
           'description', params['description'],
           'links',       params['links']
        )
        $redis.lpush("story_ids", id)
        redirect to("/stories/#{id}")

      end


    end



  end #Class
end #Perdito
