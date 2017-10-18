require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb:'index'
  end

  get '/posts/new' do

    erb:'new'
  end

  post '/posts' do
    #from form on new.erb
    #Should use Create CRUD action to create the blog post and save it to database
    # binding.pry
    @post = Post.create(params)
    #then use erb to render index view

    erb:'index'
  end

  get '/posts' do
    #Should use ActiveRecord to grab all of the posts and store them in @posts
    #Then render index.erb with all posts
    @posts = Post.all
    # binding.pry
    erb:'index'
  end

  get '/posts/:id' do
    # binding.pry
    #Use ARecord to grab post with the id in the params and set it equal to @post
    # Then render the show.erb page; this view should render the posts's title and content
    # binding.pry
    @post = Post.find(params[:id])

    erb:show
  end

  get '/posts/:id/edit' do
    #renders the view, edit.erb, This view should contain form to update
    #specific blog post and POSTS to patch '/posts/:id'
    @post = Post.find(params[:id])
    erb:edit
  end

  patch '/posts/:id' do
    #patch routing will update an instance of model given :id
    # binding.pry
    #best guess
    @post = Post.find(params[:id])

    @post.name = params[:name]
    @post.content = params[:content]
    @post.save

    erb:show
  end

  delete '/posts/:id/delete' do
    #add delete button to the show page.  Identify post and delete it, Then
    #render a delete.erb view that confirms the post has been deleted

    #best guess
    # binding.pry
    @post = Post.find(params[:id])
    @post.delete
    erb:delete
  end
end
