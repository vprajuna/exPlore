class AddUserVoteToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :user_votes, :integer, default: 0
  end
end
