Gem::Specification.new do |s|
  s.name = 'trello-changelog'
  s.version = '1.0.0'
  s.date = '2015-02-19'
  s.summary = 'Changelog for Trello'
  s.description	= 'Changelog for Trello'
  s.authors = ['Giel De Bleser', 'Steven De Coeyer', 'Joren De Groof']
  s.executables << 'trello-changelog'
  s.email = 'giel@openminds.be'
  s.files = Dir.glob("{bin,lib}/**/*")
  s.homepage = 'https://github.com/openminds/trello-changelog'
  s.license = 'MIT'

  s.add_dependency 'pry'
  s.add_dependency 'rake'
  s.add_dependency 'ruby-trello'
  s.add_dependency 'thor'
end
