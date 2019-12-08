# encoding: UTF-8
# frozen_string_literal: true

module ApplicationHelper
  def check_active(klass)
    if klass.is_a? String
      return 'active' unless (controller.controller_path.exclude?(klass))
    else
      return 'active' if (klass.model_name.singular == controller.controller_name.singularize)
    end
  end

  def top_nav_link(link_text, link_path, link_icon, controllers: [], counter: 0, target: '')
    merged = (controllers & controller_path.split('/'))
    class_name = current_page?(link_path) ? 'nav-item active' : nil
    class_name ||= merged.empty? ? nil : 'nav-item active'

    content_tag(:li, :class => class_name) do
      link_to link_path, target: target, class: "nav-link" do
        content_tag(:i, :class => "fa fa-#{link_icon}") do
          content_tag(:span, counter,class: "counter") if counter != 0
        end +
        content_tag(:span, link_text)
      end
    end
  end

  def locale_name
    I18n.locale.to_s.downcase
  end

  def body_id
    "#{controller_name}-#{action_name}"
  end

  def guide_panel_title
    @guide_panel_title || t("guides.#{i18n_controller_path}.#{action_name}.panel", default: t("guides.#{i18n_controller_path}.panel"))
  end

  def guide_title
    @guide_title || t("guides.#{i18n_controller_path}.#{action_name}.title", default: t("guides.#{i18n_controller_path}.panel"))
  end

  def guide_intro
    @guide_intro || t("guides.#{i18n_controller_path}.#{action_name}.intro", default: t("guides.#{i18n_controller_path}.intro", default: ''))
  end

  def i18n_controller_path
    @i18n_controller_path ||= controller_path.gsub(/\//, '.')
  end

  def description_for(name, &block)
    content_tag :dl, class: "dl-#{name} dl-horizontal" do
      capture(&block)
    end
  end

  def item_for(model_or_title, name='', value = nil, &block)
    if model_or_title.is_a? String or model_or_title.is_a? Symbol
      title = model_or_title
      capture do
        if block_given?
          content_tag(:dt, title.to_s) +
            content_tag(:dd, capture(&block))
        else
          value = name
          content_tag(:dt, title.to_s) +
            content_tag(:dd, value)
        end
      end
    else
      model = model_or_title
      capture do
        if block_given?
          content_tag(:dt, model.class.human_attribute_name(name)) +
            content_tag(:dd, capture(&block))
        else
          value ||= model.try(name)
          value = value.localtime if value.is_a? DateTime
          value = I18n.t(value) if value.is_a? TrueClass

          content_tag(:dt, model.class.human_attribute_name(name)) +
            content_tag(:dd, value)
        end
      end
    end
  end

  def root_url_with_port_from_request
    port  = request.env['SERVER_PORT']
    parts = [request.protocol, request.domain]
    unless port.blank?
      parts << if request.ssl?
         port == '443' ? '' : ":#{port}"
      else
        port == '80' ? '' : ":#{port}"
      end
    end
    parts.join('')
  end

  def custom_stylesheet_link_tag_for(layout)
    if File.file?(Rails.root.join('public/custom-stylesheets', "#{layout}.css"))
      tag :link, \
        rel:   'stylesheet',
        media: 'screen',
        href:  "/custom-stylesheets/#{layout}.css"
    end
  end

  # Yaroslav Konoplov: I don't use #image_path & #image_url here
  # since Gon::Jbuilder attaches ActionView::Helpers which behave differently
  # compared to what ActionController does.
  def currency_icon_url(currency)
    if currency.id == 'bgc'
      ActionController::Base.helpers.image_url "assets/#{currency.code}.png"
    else
      ActionController::Base.helpers.image_url "assets/#{currency.code}.svg"
    end
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end

  def price_change(open_price, last_price)
    if open_price > 0
      percent = 100*(last_price-open_price)/open_price
    else
      percent = '0.00'
    end
    "#{open_price > last_price ? '' : '+'}#{sprintf('%.2f', percent) }%"
  end

  def swith_coins
    array = []
    gon.markets.each do |market| 
      array << market[1]['bid_unit']
    end
    array.uniq
  end

  def check_deposit_sum(member)
    sum = 0
    Deposit.where(member: member, aasm_state: :accepted).each do |deposit|
      if deposit.currency_id != 'usd'
        sum += deposit.amount.to_f * Gon.tickers["#{deposit.currency_id}usd"][:last].to_f
      else
        sum += deposit.amount.to_f
      end
    end
    sum
  end

  def calc_total_balance(member)
    sum = 0
    member.accounts.each do |account|
      if account.currency_id != 'usd'
        sum += account.balance.to_f * Gon.tickers["#{account.currency_id}usd"][:last].to_f
      else
        sum += account.balance.to_f
      end
    end
    sum
  end

  def calc_change(account)
    open_price = Gon.tickers["#{account.currency_id}usd"][:open].to_f
    last_price = Gon.tickers["#{account.currency_id}usd"][:last].to_f
    if open_price > 0
      percent =  (100*(last_price-open_price)/open_price).round(2)
    else
      percent = '0.0'
    end
    "#{open_price > last_price ? '' : '+'}#{percent}"
  end
end
