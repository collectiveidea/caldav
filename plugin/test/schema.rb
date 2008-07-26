ActiveRecord::Schema.define(:version => 0) do
  create_table :users, :force => true do |t|
    t.column :name, :string
  end
  
  create_table :courses, :force => true do |t|
    t.column :name, :string
    t.column :user_id, :integer
    t.column :activecaldav_uid, :integer
  end
  
end