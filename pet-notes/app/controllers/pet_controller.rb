class PetController < ApplicationController

    get '/pets/new' do 
        if logged_in?
            erb :'/pets/add_pet'
        else
            redirect to '/login'
        end
    end 

    post '/pets/new' do
        if logged_in? && params[:name] != "" && params[:breed] != "" && params[:nutrition] != "" && params[:feedings] != ""  && params[:notes] != ""  && params[:img] != ""
            @new_pet = Pet.create(params)
            @new_pet.user_id = current_user.id
            @new_pet.save
            flash[:success] = "Successfully created Pet Profile!"
            redirect to "/users/index"  
        else
            redirect to '/login'
        end
    end 

    get '/pets/:id' do
        @pet = Pet.find(params[:id])
        erb :'/pets/individual_pet'
    end 

    get '/pets/:id/edit' do 
        @pet = Pet.find(params[:id])
        erb :'/pets/edit_pet'
    end 

    patch '/pets/:id' do 
        @pet = Pet.find(params[:id])
        if params[:name] != "" && params[:breed] != "" && params[:nutrition] != "" && params[:feedings] != ""  && params[:notes] != ""  && params[:img] != ""
          @pet.update(:name => params[:name], :breed => params[:breed], :nutrition => params[:nutrition], :feedings => params[:feedings], :notes => params[:notes], :img => params[:img])
        end
        @pet.user_id = current_user.id
        @pet.save
        flash[:success] = "Successfully updated Pet Profile!"
        redirect to "/pets/#{@pet.id}"  
    end 

    get '/pets/:id/delete' do 
        @pet = Pet.find(params[:id])
        @pet.delete
        flash[:success] = "Pet Profile has been deleted."
        redirect to "/users/index" 
    end 

   # Not functioning yet
   # post '/upload' do
       #  Check if user uploaded a file
        #if params[:img] && params[:img][:filename]
         # filename = params[:img][:filename]
         # file = params[:img][:tempfile]
        #  path = "./public/uploads/#{filename}"
      
          # Write file to disk
         # File.open(path, 'wb') do |f|
          #  f.write(file.read)
         # end
       # end
     # end

      get '/pets/:slug' do
        @pet = Pet.find_by_slug(params[:slug])
        erb :"/pets/#{@pet.slug}"
      end

end 
