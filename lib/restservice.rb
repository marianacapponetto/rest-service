require 'restclient'

module RestService
  @server =  'http://localhost'
  @port =   '3000'
  @source = ''
  @uri = @server + ':' + @port 
  ERRORINIT = 'You should initialize default values by calling RestService.default() method'
  ERRORARG = 'Wrong number of arguments'
  ERRORMETHOD = 'Set the default values'
  
  #example to start
  #rests = RestService.default('tasks')
  
  #*args = server , port , source 
  
  def self.initialize (*args )
	begin
		if args.length == 0
			raise NoMethodError
		elsif
			if args.size == 1
				@source = args[0]
				@uri = @uri + '/' + @source
			else		
				@server = args[0]
				@port = args[1]
				@source = args[2]
				@uri = @server + ':' + @port + '/' + @source
			end	
		end
	rescue NoMethodError => e
		puts ERRORMETHOD
	end
	
  end
  
  #example to delete
  #response = RestService.delete '14'
  #puts response
  #response.code
  def self.delete (id='')    
	begin
		if id == ''
			raise ArgumentError
		elsif
			urids =  @uri + '/' +id         
			RestClient.delete urids
		end
	rescue RestClient::ResourceNotFound => e
		ERRORINIT #e.message
	rescue ArgumentError => e
		puts ERRORARG
	end
  end
  
  #example to show
  # res = RestService.show '16'
  #puts response
  #response.code    
  def self.show(id='') 
	begin
		if id == ''
			raise ArgumentError
		elsif
			urids = @uri + '/' +id         
			response = RestClient.get urids
			return response
		end
	rescue RestClient::ResourceNotFound => e
		ERRORINIT #e.message 
	rescue ArgumentError => e
		puts ERRORARG
	end
end

  #example to create
  #res = RestService.create ({:title => "tarea7", :description => "tareas", :fecha => "12/12/12" })
  #puts response
  #response.code
  def self.create(value='')
	begin
		if value == ''
			raise ArgumentError
		elsif
			key = @source[0..-2] #source singularized	
			param = {key.to_sym => value}
			RestClient.post  @uri, param
		end
	rescue RestClient::ResourceNotFound => e
		ERRORINIT #e.message 
	rescue ArgumentError => e
		puts ERRORARG		
	end
  end
  
  #example to edit
  #res = RestService.edit '15', {:title => "nuevatarea", :description => "nuevadescripcion", :fecha => "12/01/11" } 
  #puts response
  #response.code
  def self.edit(id='',value='')
	begin
		if id == '' || value == ''
			raise ArgumentError
		elsif
			uriedit = @uri + '/' +id
			key = @source[0..-2] #source singularized	
			param = {key.to_sym => value}
			RestClient.put  uriedit, param 
		end
	rescue RestClient::ResourceNotFound => e
		ERRORINIT #e.message 
	rescue ArgumentError => e
		puts ERRORARG
	end    
  end
end