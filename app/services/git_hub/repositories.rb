# frozen_string_literal: true

require 'octokit'

module GitHub
  class Repositories < Base
    def initialize(username)
      @client = Octokit::Client.new
      @username = username
    end

    def call
      @client.repositories(@username)
    rescue Octokit::NotFound
      # If the user is not found, Octokit returns Octokit::NotFound
      []
    end
  end
end
