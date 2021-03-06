require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('../models/manufacturer')

get '/manufacturers' do
  @manufacturers = Manufacturer.all()
  erb(:"manufacturers/index")
end

get '/manufacturers/new' do
  erb(:"manufacturers/new")
end

post '/manufacturers' do
  manufacturer = Manufacturer.new(params)
  manufacturer.save()
  redirect to '/guitars/new'
end

get '/manufacturers/:id' do
  @manufacturer = Manufacturer.find(params['id'].to_i)
  @guitars = @manufacturer.guitars()
  erb(:"manufacturers/show")
end
