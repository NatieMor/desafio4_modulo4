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
    data_hash=JSON.parse(response.body) #en esta parte el requerimiento (request) se retorna como un HASH 
end
data_hash= request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=C6d6ya1SRztiqEpUbmTMl08Btkeefy7NuRDvt4Gf')
 puts data_hash["photos"]#se imprime el retorno del request como un HASH, atraves del uso de la key, se imprime el valor de la key "photos"

 puts data_hash["photos"][0..10]
 #tiene que ser un ciclo..
 data_hash["photos"].each do |elemento|
               puts "la id es #{data_hash["photos"][0]["id"]} y la imagen es #{data_hash["photos"][0]["img_src"]}"
      puts
end

