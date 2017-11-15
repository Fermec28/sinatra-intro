class CreateEntrys < ActiveRecord::Migration[5.0]
  def change
  	create_table :entries do |t|
  		t.string :autor
  		t.string :title
  		t.text :content
  		t.integer :likes

  		t.timestamps
  	end
  end
end
