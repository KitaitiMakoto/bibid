require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class BookTest < Test::Unit::TestCase
  context "Book Model" do
    should 'construct new instance' do
      @book = Book.new
      assert_not_nil @book
    end
  end
end
