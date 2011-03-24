Gem::Specification.new do |s|
  s.name      = 'foo'
  s.version   = '0.0.1'
  s.date      = '2011-01-01'

  s.homepage    = "https://github.com/josh/foo"
  s.summary     = "<GitHub description>"
  s.description = <<-EOS
    <README description>
  EOS

  s.files = [
    'LICENSE',
    'README.md'
  ]

  s.add_dependency 'bar'
  s.add_development_dependency 'baz'

  s.authors = ["Joshua Peek"]
  s.email   = "josh@joshpeek.com"
end
