module BinaryBeast
  
  # Service
  # Class
  # ---------------
  # This is the base service class that all other classes inherit from, it provides the basic
  # API interaction functionality, in order to make this API library a bit more DRY
  # ---------------
  # gives you a Service object
  
  class Service

    # assignAttributes
    # Method
    # ---------------
    # Used by the service class constructors to iterate through inputs to quickly assign the values
    # into the instance variables
    # For example in Tournament::initialize({:title=>'title of the tour'}), :title will automatically be assigned to this.title = 'Title of the tour' 
    # ---------------
    def self.assignAttributes(attributes = {})
      attributes.each_pair do |key, value|
        self.send("#{key}=", value)
      end
    end
    
    # getAttributes
    # Method
    # ---------------
    # Used by service methods for calling update services without having 
    # to type out every single attribute in the code, once they're listed as
    # an attr_accessor, it will be sent - if there happen to be extraneous values, it won't make any difference   
    # ---------------
    def getAttributes()
      Hash[instance_variables.map {|attr| [attr.slice(1..-1), instance_variable_get(attr)] } ]
    end

    def initialize()
      self.test1 = 'yay'
      self.test2 = 'wtf'
      self.test3 = 15
      self.test4 = nil
      self.test5 = false
    end

  end

end