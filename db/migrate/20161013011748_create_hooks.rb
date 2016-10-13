class CreateHooks < ActiveRecord::Migration[5.0]
  def change
    create_table :hooks do |t|
      t.text :url
    end
  end
end
