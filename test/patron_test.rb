require 'minitest/autorun'
require 'minitest/pride'
require './lib/patron'

class PatronTest < Minitest::Test

  def setup
     @bob = Patron.new("Bob", 20)
  end

  def test_it_exists
    assert_instance_of Patron, @bob
  end

  def test_it_has_attributes
    assert_equal "Bob", @bob.name
    assert_equal 20, @bob.spending_money
    assert_equal [], @bob.interests #initial interests
  end

end
