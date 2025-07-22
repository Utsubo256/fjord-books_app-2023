class AddPostalCodeAddressAndBiographyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :postal_code, :string, null: true, comment: "郵便番号"
    add_column :users, :address, :string, null: true, comment: "住所"
    add_column :users, :biography, :text, null: true, comment: "自己紹介文"
  end
end
