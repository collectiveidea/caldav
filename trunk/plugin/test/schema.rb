ActiveRecord::Schema.define(:version => 0) do
  create_table :users, :force => true do |t|
    t.column :name, :string
  end
  
  create_table :events, :force => true do |t|
  end
end