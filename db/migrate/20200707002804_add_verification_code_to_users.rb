class AddVerificationCodeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :verification_code, :integer
    add_column :users, :verification_used, :boolean, default: false
  end
end
