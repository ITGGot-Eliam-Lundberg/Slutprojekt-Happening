class App < Sinatra::Base
  enable :sessions

  get '/' do
    @first = "false"
    if session[:user_id]
      @current_user = User.get(session[:user_id])
      @relevant_happenings = @current_user.followees.happenings
      slim(:start)
    else
      slim :index, layout: false
    end
  end

  get '/login' do
    @current_user = User.get(session[:user_id]) if session[:user_id]
    if @current_user
      redirect '/'
    else
      slim :login, layout: false
    end
  end

  post '/registration' do
    if params["password"] == params["password_check"]
      user = User.create(e_mail: params["epost"],
                 full_name: params["fullt_namn"],
                 password: params["password"])
      if user && user.valid?
         session[:user_id] = user.id
      else
      end
    end
    redirect '/'
  end

  post '/logging_in' do
    user = User.first(:e_mail => params["epost"])
    if user && user.password == params["password_check"]
      session[:user_id] = user.id
    else
      redirect back
    end
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  post '/search' do
    search_input = params['search_input']
    if session[:user_id]
      @current_user = User.get(session[:user_id])
      @relevant_users = User.all(:full_name.like => "%#{search_input}%")
      @relevant_users = User.all(:description.like => "%#{search_input}%") if @relevant_users.empty?
      slim :searchsite
    else
      redirect '/login'
    end
  end

  get '/searchbox' do
    @current_user = User.get(:user_id)
    if session[:user_id]
      @current_user = User.get(session[:user_id])
      slim :searchbox, layout: false
    else
      redirect '/login'
    end
  end

  get '/avatar/:pic' do |pic|
    send_file "./avatars/#{pic}"
  end

  get '/profile/:id' do |id|
    @profile_user = User.get(id)
    if session[:user_id]
      @current_user = User.get(session[:user_id])
      slim :profile
    else
      redirect '/login'
    end
  end

  get '/profile/:id/edit' do |id|
    @edit_for_user = User.get(id)
    if session[:user_id]
      @current_user = User.get(session[:user_id])
      if @current_user === @edit_for_user
      slim :edit_profile
      else
        redirect back
      end
    else
      redirect '/login'
    end
  end

  post '/profile/:id/edit/save' do |id|
    @current_user = User.get(session[:user_id])
    if @current_user.id == id.to_i
      @current_user.update(full_name: params["fullt_namn"],
                           description: params["beskrivning"])
      redirect "/profile/#{@current_user.id}"
    else
      redirect '/'
    end
  end

  get '/settings/:id' do |id|
    @settings_for_user = User.get(id)
    if session[:user_id]
      @current_user = User.get(session[:user_id])
      if @current_user == @settings_for_user
        slim :settings, layout: false
      else
        redirect back
      end
    else
      redirect '/login'
    end
  end

    post '/settings/:id/save' do |id|
    @current_user = User.get(session[:user_id])
    if @current_user.id == id.to_i && params["password_check"] == @current_user.password
      @current_user.update(e_mail: params["epost"],
                           birth_date: params["birth-date"],
                           phone_number: params["phone-number"],
                           password: params["password"])
      redirect '/'
    else
      redirect '/settings/:id'
    end
  end

  post '/follow-relation/:id' do |id|
    @current_user = User.get(session[:user_id])
    if @current_user
      Following.first(:follower_id => @current_user, :followee_id => id)
      redirect back
    else
      redirect '/'
    end
  end

  get '/messages/:id' do |id|
    if session[:user_id]
      @current_user = User.first(id: id)
      slim :messages
    else
      redirect '/login'
    end
  end

  get '/calendar/:id' do |id|
    if session[:user_id]
      @current_user = User.first(id: id)
      slim :calendar
    else
      redirect '/login'
    end
  end

  get '/happening/create' do
    if session[:user_id]
      @current_user = User.get(session[:user_id])
      slim :happenings, layout: false
    else
      redirect '/login'
    end
  end
end