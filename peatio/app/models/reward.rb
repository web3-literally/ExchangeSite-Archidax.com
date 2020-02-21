class Reward < ActiveRecord::Base
  belongs_to :member, required: true
end

# == Schema Information
# Schema version: 20190612011336
#
# Table name: rewards
#
#  id             :integer          not null, primary key
#  member_id      :integer
#  currency_id    :string(255)
#  amount         :decimal(32, 16)  default(0.0)
#  usd_amount     :decimal(32, 16)  default(0.0)
#  ref_type       :string(255)
#  trade_id       :integer
#  from_member_id :integer
#  created_at     :datetime         not null
#
# Indexes
#
#  index_rewards_on_member_id  (member_id)
#  index_rewards_on_ref_type   (ref_type)
#
