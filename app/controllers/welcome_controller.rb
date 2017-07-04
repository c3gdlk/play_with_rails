class WelcomeController < ApplicationController
  attr_accessor :initial_name


  def self.set_name(value)
    @name = value
  end

  set_name 'Bruce'

  def self.name
    @name
  end

  def initialize
    super 

    self.initial_name = self.class.name
  end

  def index
    names = ['Bruce', 'John', 'david']
    
    name = 'Names: '  

    new_names = names.select { |item| item.length > 4 }. map {|item| item.upcase}


    @name = new_names.join(',')
    # @name = self.class.name
  end

  protected

  def name
    initial_name || 'Bruce'
  end  
end
