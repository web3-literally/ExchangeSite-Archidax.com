class AddLoginIpToMembers < ActiveRecord::Migration
  def change
    add_column :members, :login_ip, :string
    add_column :members, :login_time, :date
  end
end
