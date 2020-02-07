# frozen_string_literal: true

class Order
    attr_reader :user

    def initialize(user)
      @user = user
    end
  end
