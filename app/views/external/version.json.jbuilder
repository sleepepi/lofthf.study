# frozen_string_literal: true

json.version do
  json.string LoftHF::VERSION::STRING
  json.major LoftHF::VERSION::MAJOR
  json.minor LoftHF::VERSION::MINOR
  json.tiny LoftHF::VERSION::TINY
  json.build LoftHF::VERSION::BUILD
end
