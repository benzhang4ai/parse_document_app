class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :document_type
      t.json :data, default: {}

      t.timestamps
    end
  end
end
