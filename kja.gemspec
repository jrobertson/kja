Gem::Specification.new do |s|
  s.name = 'kja'
  s.version = '0.2.0'
  s.summary = 'Downloads and plays King James Bible OGG files from rorbuilder.info'
  s.authors = ['James Robertson']
  s.files = Dir['lib/kja.rb']
  s.add_runtime_dependency('dynarex', '~> 1.7', '>=1.7.22') 
  s.signing_key = '../privatekeys/kja.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/kja'
end
