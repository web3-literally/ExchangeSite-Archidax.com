class AddReferralToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :referral_code, :string
  end
end
