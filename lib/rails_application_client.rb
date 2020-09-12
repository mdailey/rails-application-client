# frozen_string_literal: true

require "rails/application/client/version"

module RailsApplicationClient
  def self.greet(name)
    puts "Hello, #{name}! I'm rails app client!"
  end
end
