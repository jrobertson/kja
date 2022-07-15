Gem::Specification.new do |s|
  s.name = 'kja'
  s.version = '0.3.1'
  s.summary = 'Downloads and plays King James Bible OGG files from jamesrobertson.me.uk'
  s.authors = ['James Robertson']
  s.files = Dir['lib/kja.rb']
  s.add_runtime_dependency('dynarex', '~> 1.9', '>=1.9.11')
  s.add_runtime_dependency('kj_reading', '~> 0.3', '>=0.3.0')
  s.signing_key = '../privatekeys/kja.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/kja'
end
