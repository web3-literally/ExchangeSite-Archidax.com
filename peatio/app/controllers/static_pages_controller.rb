# encoding: UTF-8
# frozen_string_literal: true

class StaticPagesController < ApplicationController
  layout 'static_pages'
  include Concerns::DisableCabinetUI

  def about
  end

  def exchage_platform
  end

  def terms_of_use
  end

  def privacy_policy
  end

  def mining
  end

  def api
  end

  def mobile_app
  end

  def help_center
  end

  def faq
  end

  def fees
    
  end
end
