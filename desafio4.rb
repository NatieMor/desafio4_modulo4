require 'uri'
require 'net/http'
require 'json'

#REQUERIMIENTO1
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
$data= request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=C6d6ya1SRztiqEpUbmTMl08Btkeefy7NuRDvt4Gf")
puts "Se retorno un #{$data.class} con los siguientes datos (valores): " #aqui comprobamos que nos devolvio un HASH
puts
puts $data.values #conocemos cuales son los valores del HASH
puts #Aqui conocemos la keys, la clase que lo conforma y el nombre de las key
puts "La key del hash es: #{$data.keys} , que esta formando un #{$data["photos"].class} compuesto por las siguientes KEYS #{$data["photos"][0].keys}" #conocemos cuales son las keys
puts 

#REQUERIENTO 2
def buid_web_page(data)
  html="<html>
  <meta charset='utf-8'/>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no' />
  <meta name='copyright' content='derechos reservados. Proibida su reproducción' />
  <meta name='author' content='Nathalie Moraga'/>
  <meta name='description' content='imagenes nasa'/>
  <meta name='keyword' content='espacio, nacio, sol, rover, imagenes, ciencia'/>
  <link rel='shortcut icon' href='x'/>
  <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.6.3/css/all.css'
    integrity='sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/'crossorigin='anonymous'/>
  <link rel='stylesheet'type='text/css' href='asset/css/Style.css' />
  <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css'
    integrity='sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm' crossorigin='anonymous'/>
  <link href='https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Playfair+Display&display=swap'
    rel='stylesheet'>
   <title>Imagenes del sol NASA</title>
  </head>
  <body>
  <div class='container-fluid text-center'>
    <h1 class='display-1 text-center'>Imagenes NASA </h1>
    <div class='row col-6 d-inline'>
    "
    $data["photos"].each do |elemento|
    elemento["id"]
    elemento["img_src"]
    elemento["earth_date"]
     #print "ID de la imagen: #{elemento["id"]} y su link: #{elemento["img_src"]}" 
     html << "<ul class='mb-3'>
     <div class='card container col-12 mb-2'>
     <img src=' #{elemento["img_src"]}' class='card-img-bottom' alt='#{elemento["id"]}' title='#{elemento["earth_date"]}'>
     <div class='card-body'>
    <h2 class='card-title display-6 text-success'> Imagen # #{elemento["id"]}</h2>
    </div>
  </div>
  </ul>"
  end
  html << "
  </div>
  </div>
  <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js' integrity='sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz' crossorigin='anonymous'></script>
  </body>
  </html>"
  File.write('index.html', html)
  end
  buid_web_page($data)

  #REQUERIENTO 3
  def photos_count(data)
    i = 0
    $data["photos"].each do |elemento|
        i += 1
    end
    puts "Tenemos #{i} Imagenes de la NASA"
  end
  photos_count($data)
