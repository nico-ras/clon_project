class CreateTagsTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tags_tweets, :id => false do |t|
      t.references :tweet, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps
    end
  end
end
