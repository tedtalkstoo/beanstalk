task :api_call => :environment do

  # address = "http://localhost:3000/api_external/blank_api"
  # address = "http://beanstalk-env.cxuzvsqj4p.eu-west-1.elasticbeanstalk.com/api_external/blank_api"
  address = "http://beanstalk-env.exuvm7eqcp.eu-west-1.elasticbeanstalk.com/api_external/blank_api"

  response = RestClient.post(address, '')
  body = JSON.parse(response.body)
  puts body

end
