Gem::Specification.new do |s|
  s.name = 'kja'
  s.version = '0.1.0'
  s.summary = 'kja'
  s.authors = ['James Robertson']
  s.files = Dir['lib/kva.rb','ogg/*']
  s.signing_key = '../privatekeys/kja.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/kja'
end
