require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class UserTest < Test::Unit::TestCase
  context "User Model" do
    should 'construct new instance' do
      @user = User.new
      assert_not_nil @user
    end
  end
end
