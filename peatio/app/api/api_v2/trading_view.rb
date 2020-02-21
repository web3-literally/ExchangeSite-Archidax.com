module APIv2
  class TradingView < Grape::API
    helpers ::APIv2::NamedParams

    namespace 'tradingview' do
      desc 'Returns TradingView Config'
      get :config do
        {
            supports_search: true,
            supports_group_request: false,
            supports_marks: false,
            supports_timescale_marks: false,
            supports_time: true,
            exchanges: [
                {
                    value: 'STOCK',
                    name: 'Excoincial',
                    desc: ''
                }
            ],
            symbols_types: [{
                                name: 'Cryptocurrency',
                                value: 'crypto'
                            }],
            supported_resolutions: [
                '1', '15', '30', # Minutes
                '60', # Hours
                '1D', '3D', # Days
                '1W', # Weeks
                '1M' # Months
            ]
        }
      end


      params do
        requires :symbol, type: String, desc: 'Symbol Name'
      end
      desc 'Returns Symbols'
      get :symbols do
        {
            "name" => params[:symbol],
            "exchange-traded" => "",
            "exchange-listed" => "",
            "timezone" => "Europe/Paris",
            "minmovement" => 1,
            "minmovement2" => 0,
            "pointvalue" => 1,
            "session" => "24x7",
            "has_intraday" => true,
            "has_no_volume" => false,
            "description" => params[:symbol],
            "has_empty_bars" => false,
            "type" => "bitcoin",
            "supported_resolutions" => ["1", "15", "30", "60", "D", "3D", "W", "M"],
            "pricescale" => 100000000,
            "ticker" => params[:symbol],
            "force_session_rebuild" => false
        }
      end

      desc 'Returns system time'
      get :time do
        Time.now.to_i
      end

      desc 'Returns history bars'
      params do
        requires :symbol, type: String, desc: 'Symbol Name'
        requires :resolution, type: String, desc: 'resolution'
        requires :from, type: Integer, desc: 'Symbol Name'
        requires :to, type: Integer, desc: 'Symbol Name'
      end
      get :history do
        # { :symbol => params[:symbol], :period => resolution_to_period(params[:resolution])}
        klines = KLineService.new(params[:symbol], resolution_to_period(params[:resolution]))
                     .get_ohlc({:time_from => params[:from], :time_to => params[:to]})
        klines = klines.select {|k| k[5] > 0}
        if klines.length == 0
          {s: 'no_data'}
        else
          convert_klines_to_bars(klines)
        end
      end

    end


  end
end

