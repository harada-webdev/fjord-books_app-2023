class CreateReportMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :report_mentions do |t|

      t.timestamps
    end
  end
end
