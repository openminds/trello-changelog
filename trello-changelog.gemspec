Gem::Specification.new do |spec|
  spec.name = 'trello-changelog'
  spec.version = '1.0.0'
  spec.date = '2015-02-19'
  spec.summary = 'Changelog for Trello'
  spec.description	= 'Changelog for Trello'
  spec.authors = ['Giel De Bleser', 'Steven De Coeyer', 'Joren De Groof']
  spec.executables << 'trello-changelog'
  spec.email = 'giel@openminds.be'
  spec.files = Dir.glob("{bin,lib}/**/*")
  spec.homepage = 'https://github.com/openminds/trello-changelog'
  spec.license = 'MIT'

  spec.add_development_dependency 'pry'
  spec.add_runtime_dependency 'rake'
  spec.add_runtime_dependency 'ruby-trello'
  spec.add_runtime_dependency 'thor'
end
