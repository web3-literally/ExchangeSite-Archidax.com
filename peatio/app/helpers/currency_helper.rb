# encoding: UTF-8
# frozen_string_literal: true

module CurrencyHelper
  # Yaroslav Konoplov: I don't use #image_path & #image_url here
  # since Gon::Jbuilder attaches ActionView::Helpers which behave differently
  # compared to what ActionController does.
  def currency_icon_url(currency)
      ActionController::Base.helpers.image_url currency_icon_url(currency)
  end

  private

  def currency_icon_url(currency)
    if currency.icon_url.blank?
      if currency.id == 'bgc'
        "assets/#{currency.code}.png"
      else
        "assets/#{currency.code}.svg"
      end
    else
      currency.icon_url
    end
  end

end
