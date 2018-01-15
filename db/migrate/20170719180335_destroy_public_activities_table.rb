class DestroyPublicActivitiesTable < ActiveRecord::Migration[5.0]
  def up
    # drop_table :activities
  end

  def down
    create_table :activities do |t|
      t.belongs_to :trackable, polymorphic: true
      t.belongs_to :owner, polymorphic: true
      t.string  :key
      t.text    :parameters
      t.belongs_to :recipient, polymorphic: true

      t.timestamps
    end

    add_index :activities, [:trackable_id, :trackable_type]
    add_index :activities, [:owner_id, :owner_type]
    add_index :activities, [:recipient_id, :recipient_type]
  end
end
