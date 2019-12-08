# encoding: UTF-8
# frozen_string_literal: true

module Admin
  class RewardsController < BaseController
    def index
      @rewards = Reward.order("id desc").page(params[:page]).per(20)
    end
  end
end
