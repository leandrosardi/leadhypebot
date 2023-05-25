Gem::Specification.new do |s|
    s.name        = 'leadhypebot'
    s.version     = '1.2'
    s.date        = '2023-05-25'
    s.summary     = "Ruby library for automation operation on the LeadHype Scraper platform."
    s.description = "Find documentation here: https://github.com/leandrosardi/leadhypebot"
    s.authors     = ["Leandro Daniel Sardi"]
    s.email       = 'leandro.sardi@expandedventure.com'
    s.files       = [
      'lib/leadhypebot.rb',
    ]
    s.homepage    = 'https://rubygems.org/gems/leadhypebot'
    s.license     = 'MIT'
    s.add_runtime_dependency 'blackstack-core', '~> 1.2.3', '>= 1.2.3'
    s.add_runtime_dependency 'simple_command_line_parser', '~> 1.1.2', '>= 1.1.2'
    s.add_runtime_dependency 'simple_cloud_logging', '~> 1.2.2', '>= 1.2.2'
    s.add_runtime_dependency 'mechanize', '~> 2.8.5', '>= 2.8.5'
    s.add_runtime_dependency 'colorize', '~> 0.8.1', '>= 0.8.1'
    s.add_runtime_dependency 'pry', '~> 0.14.2', '>= 0.14.2'
end