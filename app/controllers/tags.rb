class BookmarkManager < Sinatra::Base

    get '/tag/:tag' do
      tag = Tag.all(:tag => params[:tag])
      @links = tag.links
      erb :'links/index'
    end

end
