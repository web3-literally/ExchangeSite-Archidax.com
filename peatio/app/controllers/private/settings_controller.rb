# encoding: UTF-8
# frozen_string_literal: true

module Private
  class SettingsController < BaseController
  	include ApplicationHelper
  	layout 'settings'
  	before_action :auth_member!

    def index
    end

    def dashboard
    	@accounts = current_user.accounts
    	@trades = current_user.trades
    	@deposits_sum = check_deposit_sum(current_user)
    	@total_balance = calc_total_balance(current_user)

      @deposits = Deposit.where(member: current_user)
      @withdraws = Withdraw.where(member: current_user)

      @transactions = @deposits + @withdraws
      @canceled_tr = @deposits.where(aasm_state: :canceled) + @withdraws.where(aasm_state: :canceled)
      @completed_tr = @deposits.where(aasm_state: :accepted) + @withdraws.where(aasm_state: :succeed) + @withdraws.where(aasm_state: :done) + @withdraws.where(aasm_state: :accepted)
      @pending_tr = @deposits.where(aasm_state: :submitted) + @withdraws.where(aasm_state: :processing) + @withdraws.where(aasm_state: :confirming)
      @other_tr = @transactions - @completed_tr - @pending_tr - @canceled_tr

      if @transactions.count > 0
        @completed_tr_pr = ( @completed_tr.count / @transactions.count * 100 ).round(2)
        @pending_tr_pr = ( @pending_tr.count / @transactions.count * 100 ).round(2)
        @canceled_tr_pr = ( @canceled_tr.count / @transactions.count * 100 ).round(2)
        @other_tr_pr = ( @other_tr.count / @transactions.count * 100 ).round(2)
      else
        @completed_tr_pr = 0
        @pending_tr_pr = 0
        @canceled_tr_pr = 0
        @other_tr_pr = 0
      end

    end
  end
end

