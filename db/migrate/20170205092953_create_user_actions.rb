class CreateUserActions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_actions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :action, foreign_key: true
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
