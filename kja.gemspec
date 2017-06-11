Gem::Specification.new do |s|
  s.name = 'kja'
  s.version = '0.1.3'
  s.summary = 'Downloads and plays King James Bible OGG files from rorbuilder.info'
  s.authors = ['James Robertson']
  s.files = Dir['lib/kva.rb']
  s.add_runtime_dependency('rxfhelper', '~> 0.4', '>=0.4.2') 
  s.signing_key = '../privatekeys/kja.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/kja'
end
