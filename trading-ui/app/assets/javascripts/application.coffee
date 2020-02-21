#= require es5-shim.min
#= require es5-sham.min

#= require jquery
#= require jquery_ujs
#= require jquery.mousewheel
#= require jquery-timing.min
#= require jquery.nicescroll.min
#
#= require bootstrap-sprockets
#= require bootstrap
#= require bootstrap-switch.min
#
#= require moment
#= require bignumber
#= require underscore
#= require cookies.min
#= require flight.min

#= require ./lib/sfx
#= require ./lib/notifier
#= require ./lib/ranger_events_dispatcher
#= require ./lib/ranger_connection


#= require highstock
#= require_tree ./highcharts/

#= require_tree ./helpers
#= require_tree ./component_mixin
#= require_tree ./component_data
#= require_tree ./component_ui
#= require_tree ./templates

#= require_self
#= require ./tv-chart-widget-init

$ ->
  window.notifier = new Notifier()

  BigNumber.config(ERRORS: false)

  HeaderUI.attachTo('header')
  AccountSummaryUI.attachTo('#account_summary')

  FloatUI.attachTo('.float')
  KeyBindUI.attachTo(document)
  AutoWindowUI.attachTo(window)

  PlaceOrderUI.attachTo('#bid_entry')
  PlaceOrderUI.attachTo('#ask_entry')
  OrderBookUI.attachTo(['#order_book_ask', '#order_book_bid'])
  DepthUI.attachTo('#depths_wrapper')

  MyOrdersUI.attachTo('#my_orders')
  MarketTickerUI.attachTo('#ticker')
  MarketSwitchUI.attachTo('#market_list_wrapper')
  MarketTradesUI.attachTo('#market_trades_wrapper')

  MarketData.attachTo(document)
  GlobalData.attachTo(document, {ranger: window.ranger})
  MemberData.attachTo(document, {ranger: window.ranger}) if gon.accounts

  CandlestickUI.attachTo('#candlestick')
  SwitchUI.attachTo('#range_switch, #indicator_switch, #main_indicator_switch, #type_switch')

  $('.panel-body-content').niceScroll
    autohidemode: true
    cursorborder: "none"

  $('.market-switch').on 'click', ->
    $('#market_list_wrapper').toggleClass 'hidden'
    $(this).toggleClass 'active'
    return

  $('li[id="settings"]').on 'click', ->
    $('li[id="settings"] .dropdown-menu').toggleClass 'hidden'
    $(this).toggleClass 'active'
    return

  $('div[id="language"]').on 'click', ->
    $('div[id="language"] .dropdown-menu').toggleClass 'hidden'
    $(this).toggleClass 'active'
    return

  $('#chart-switch li').each ->
    $(this).click ->
      if $(this).attr('class') == 'depth'
        $('#depths_wrapper').removeClass 'hidden'
        $('#candlestick').addClass 'hidden'
        $('#tradingview').addClass 'hidden'
        $('#indicator_switch_wrapper').addClass 'hidden'
        $('#range_switch').addClass 'hidden'
        $('#indicator_switch_wrapper').addClass 'hidden'
        $('#chart-switch li').each ->
          $(this).removeClass 'active'
          return
        $(this).addClass 'active'
      else if location.href.includes('ethbtc') && $(this).attr('class') == 'tradingView'
        window.location.reload()
      else if $(this).attr('class') == 'tradingView'
        $('#depths_wrapper').addClass 'hidden'
        $('#candlestick').addClass 'hidden'
        $('#tradingview').removeClass 'hidden'
        $('#indicator_switch_wrapper').addClass 'hidden'
        $('#range_switch').addClass 'hidden'
        $('#indicator_switch_wrapper').addClass 'hidden'
        $('#chart-switch li').each ->
          $(this).removeClass 'active'
          return
        $(this).addClass 'active'
      else if $(this).attr('original') == 'original'
        $('#depths_wrapper').addClass 'hidden'
        $('#candlestick').remove 'hidden'
        $('#trading-view-html').addClass 'hidden'
        $('#tradingview').addClass 'hidden'
        $('#indicator_switch_wrapper').removeClass 'hidden'
        $('#range_switch').removeClass 'hidden'
        $('#chart-switch li.original').addClass 'active'
      else
        $('#depths_wrapper').addClass 'hidden'
        $('#candlestick').removeClass 'hidden'
        $('#tradingview').addClass 'hidden'
        $('#indicator_switch_wrapper').removeClass 'hidden'
        $('#range_switch').removeClass 'hidden'
        $('#chart-switch li').each ->
          $(this).removeClass 'active'
          return
        $('#chart-switch li.original').addClass 'active'
    return
