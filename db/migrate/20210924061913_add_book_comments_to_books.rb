class AddBookCommentsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :book_comments, :string
  end
end
