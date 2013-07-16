require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class AuthenticationTest < Test::Unit::TestCase
  context "Authentication Model" do
    should 'construct new instance' do
      @authentication = Authentication.new
      assert_not_nil @authentication
    end
  end
end
