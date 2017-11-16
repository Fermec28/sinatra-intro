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

get '/entries/:id/edit' do
	@entry=Entry.find(params[:id]) 
	erb :"/entries/edit"
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
 	redirect "/entries"
 else
 	@errors= entry.errors.full_messages
 	erb :"/index"
 end 

end


patch '/entries/:id' do
 entry= Entry.find(params[:id])
 if entry.update(params[:entry])
 	#eliminar los que ya no esten
 	tags=entry.content.scan(/#\w+/)
 	entry.tags.each  do|tag_entry|
 		#recorro los tags viejos
 		unless tags.include? tag_entry.content  
 			#si los nuevos tags no incluyen el viejo elimine la relacion

 			entry.tags.delete(tag_entry)
 		end
 	end

 	tags.each do |tag|
 		unless Tag.find_by(content: tag) 			
 		 	entry.tags.create(content: tag)
 		 else 
 		 	if entry.tags.find_by(content: tag)  # Exiten Tags asociados a entry con el mismo TAG?
 		 		#si si :no haga nada porque ya estan asociados
 		 	else
 		 		#si no: asocielos
 		 	entry.tags << Tag.find_by(content: tag)
 		 	end
 		 end 
 	end
 	redirect "/entries/#{entry.id}"
 else
 	@errors= entry.errors.full_messages
 	erb :"/entries/#{entry.id}/edit"
 end
	
end

delete '/entries/:id' do
  Entry.delete(params[:id])
  redirect "/"
end


