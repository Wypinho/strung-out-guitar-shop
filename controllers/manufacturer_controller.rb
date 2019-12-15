require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/manufacturer')
also_reload('./models/*')

get '/manufacturers' do
  @manufacturers = Manufacturer.all()
  erb(:"manufacturers/index")
end

get '/manufacturers/:id' do
  @manufacturer = Manufacturer.find(params['id'].to_i)
  @guitars = @manufacturer.guitars()
  erb(:"manufacturers/show")
end

# get '/manufacturers/:id/edit' do
#   @guitar = Guitar.find(params['id'].to_i)
#   @manufacturers = Manufacturer.all()
#   erb(:"manufacturers/edit")
# end
