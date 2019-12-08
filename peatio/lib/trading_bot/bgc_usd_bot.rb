module TradingBot
  class BgcUsdBot
    def initialize(*)
      @ask = :bgc
      @bid = :usd
      @member_id = 1
      @market_id = :bgcusd
      @base_volume = 10
      @duration = 20
      @step = 0.01
      @prng = Random.new
      @base_price = 2.0
    end

    def last_price
      return @base_price unless Global[@market_id].ticker[:last] > 0
      Global[@market_id].ticker[:last]
    end

    def best_buy_price
      return @base_price - 0.2 unless Global[@market_id].ticker[:buy] > 0
      Global[@market_id].ticker[:buy]
    end

    def best_sell_price
      return @base_price + 0.2 unless Global[@market_id].ticker[:sell] > 0
      Global[@market_id].ticker[:sell]
    end

    def process
      while true
        @myAsks = myAsks
        @myBids = myBids
        if @myAsks.size < 15
          make_ask_order
        end

        if @myBids.size < 15
          make_bid_order
        end

        if @myAsks.size > 40
          cancel_order myWasteAsk
        end

        if @myBids.size > 40
          cancel_order myWasteBid
        end

        sleep @duration
        make_matching_orders

      end
    end

    def make_bid_order
      for i in 0..20
        order = OrderBid.new bid: @bid, ask: @ask, member_id:@member_id, price: last_price*(1 - (@prng.rand(i * @step)).round(6)), volume: @base_volume*(0.1 + @prng.rand(0.9 + i * 0.03)).round(6), market_id: @market_id, ord_type: :limit, state: Order::WAIT
        Ordering.new(order).submit
      end
    end

    def make_ask_order
      for i in 0..20
        order = OrderAsk.new bid: @bid, ask: @ask, member_id:@member_id, price: last_price*(1 + (@prng.rand(i * @step)).round(6)), volume: @base_volume*(0.1 + @prng.rand(0.9 + i * 0.03)).round(6), market_id: @market_id, ord_type: :limit, state: Order::WAIT
        Ordering.new(order).submit
      end
    end

    def make_matching_orders
      order = OrderAsk.new bid: @bid, ask: @ask, member_id:@member_id, price: best_sell_price*(1 - (@prng.rand(0.1)).round(6)), volume: @base_volume*(0.1+@prng.rand(0.9)), market_id: @market_id, ord_type: :limit, state: Order::WAIT
      Ordering.new(order).submit
      order = OrderBid.new bid: @bid, ask: @ask, member_id:@member_id, price: best_buy_price*(1 + (@prng.rand(0.1)).round(6)), volume: @base_volume*(0.1+@prng.rand(0.9)), market_id: @market_id, ord_type: :limit, state: Order::WAIT
      Ordering.new(order).submit
    end

    def cancel_order(order)
      Ordering.new(order).cancel
    end

    def cancel_all_order
      orders = Order.where(member_id: @member_id).with_state(:wait).with_market(@market_id)
      Ordering.new(orders).cancel
    end

    def cancel_all_bids
      orders = OrderBid.where(member_id: @member_id).with_state(:wait).with_market(@market_id)
      Ordering.new(orders).cancel
    end

    def cancel_all_asks
      orders = OrderAsk.where(member_id: @member_id).with_state(:wait).with_market(@market_id)
      Ordering.new(orders).cancel
    end



    def myAsks
      OrderAsk.where(member_id: @member_id).with_state(:wait).with_market(@market_id).order(:price)
    end

    def myBids
      OrderBid.where(member_id: @member_id).with_state(:wait).with_market(@market_id).order(:price)
    end

    def myBestBid
      @myBids.last
    end

    def myWasteBid
      @myBids.first
    end

    def myBestAsk
      @myAsks.first
    end

    def myWasteAsk
      @myAsks.last
    end
  end
end

