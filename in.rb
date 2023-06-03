require 'uri'
require 'net/http'
require 'json'

def request(url_requested)
    url = URI(url_requested)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true # Se agrega esta línea
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER #aqui se evita la vulnerabilidad de la información que se esta transmitiendo, es decir se impide que un externo capture esta información.
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '5f4b1b36-5bcd-4c49-f578-75a752af8fd5'
    response = http.request(request)
    return JSON.parse(response.body) #en esta parte el requerimiento (request) se retorna como un HASH 
end 
data= request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=C6d6ya1SRztiqEpUbmTMl08Btkeefy7NuRDvt4Gf")
puts data.class 
puts
puts data
puts data["photos"].class
puts data["photos"][0].class
puts data["photos"][0]["img_src"].class
puts
puts "la HTTP de la imagen es src= #{data["photos"][0]["img_src"]} y la id de la foto es = #{data["photos"][0]["id"]}"
puts 
puts 
puts data.values
puts data.to_a.class
puts data["photos"][0].values


=begin
      html << "
        
        <img src='#{elemento["img"]}' class='card-img-top' alt='#{elemento["name"]}' title='#{elemento["name"]}'>
        <div class='card-body'>
          <h4 class='card-title display-6 text-success'>#{elemento["name"]}</h4>
          <p class='card-text'><h5><span class='badge bg-primary'>Level: #{elemento["level"]}</span></h5>
          </p>
        </div>
        </div>
        </div>
     "
    end
=end
