# frozen_string_literal: true

class Base
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def self.call!(*args, &block)
    new(*args, &block).call!
  end
end
