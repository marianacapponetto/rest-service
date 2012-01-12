require 'restclient'

module RestService
  @server =  'http://localhost'
  @port =   '3000'
  @source = ''
  @uri = @server + ':' + @port 
  
  #example to start
  #response = RestService.default('tasks')
  
  #*args = server , port , source 
  def self.default (*args )
		
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
  
  #example to delete
  #response = RestService.delete '14'
  #puts response
  #response.code
  def self.delete (id)    
    urids =  @uri + '/' +id         
    RestClient.delete urids
  end
  
  #example to show
  #response = RestService.show '16'
  #puts response
  #response.code   
  def self.show(id)
    urids = @uri + '/' +id         
    response = RestClient.get urids
    return response
  end
  
  #example to create
  #response = RestService.create ({:title => "tarea7", :description => "tareas", :fecha => "12/12/12" })
  #puts response
  #response.code
  def self.create(value)
	  #{:table => {:param1 => value1, :param2 => value2, :paramN => valueN }}
    key = @source[0..-2] #source singularized	
    param = {key.to_sym => value}
    RestClient.post  @uri, param
  end
  
  #example to edit
  #response = RestService.edit '15', {:title => "nuevatarea", :description => "nuevadescripcion", :fecha => "12/01/11" } 
  #puts response
  #response.code
  def self.edit(id,value)
    uriedit = @uri + '/' +id
    key = @source[0..-2] #source singularized	
    param = {key.to_sym => value}
    RestClient.put  uriedit, param 
  end
end