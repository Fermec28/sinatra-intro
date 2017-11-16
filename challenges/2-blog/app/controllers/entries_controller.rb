get '/' do 
	erb :"/index"
end

get '/entries' do 
	@entries = Entry.all
	erb :"/entries/index"
end

get '/entries/:id' do 
	@entry = Entry.find(params[:id])
	

	erb :"/entries/show"
end

get '/tags/:id/entries' do
	@entries= Tag.find(params[:id]).entries
	erb :"/entries/index"
end

post '/entries' do 
 entry= Entry.new(params[:entry])
 if entry.save
 	tags=entry.content.scan(/#\w+/)
 	tags.each do |tag|
 		unless Tag.find_by(content: tag)
 			
 		 	entry.tags.create(content: tag)
 		 else
 		 	entry.tags << Tag.find_by(content: tag)
 		 end 
 	end
 end
 
 redirect "/entries"

end