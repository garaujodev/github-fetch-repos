# frozen_string_literal: true

require 'octokit'

module GitHub
  class User < Base
    def initialize(username)
      @client = Octokit::Client.new
      @username = username
    end

    def call
      @client.user(@username)
    rescue Octokit::NotFound
      # If the user is not found, Octokit returns Octokit::NotFound
      nil
    end
  end
end
