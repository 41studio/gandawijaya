class AddColumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image, :string
    add_column :users, :gender, :integer
    add_column :users, :birthday, :string
    add_column :users, :subscribe, :boolean
    add_column :users, :handphone, :string
    add_column :users, :term_of_user, :boolean
    add_column :users, :status, :string
    add_column :users, :last_ip, :string
    add_column :users, :user_agent, :string
  end
end
