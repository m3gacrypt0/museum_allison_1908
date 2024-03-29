require 'minitest/autorun'
require 'minitest/pride'
require './lib/museum'
require './lib/exhibit'
require './lib/patron'

class MuseumTest < Minitest::Test

  def setup
     @dmns = Museum.new("Denver Museum of Nature and Science")
     @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
     @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
     @imax = Exhibit.new("IMAX", 15)
     @bob = Patron.new("Bob", 20)
     @bob.add_interest("Dead Sea Scrolls")
     @bob.add_interest("Gems and Minerals")
     @sally = Patron.new("Sally", 20)
     @sally.add_interest("IMAX")
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_has_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits # initial exhibits
  end

  def test_method_add_exhibit
    @dmns.add_exhibit(@gems_and_minerals)
    assert_equal [@gems_and_minerals], @dmns.exhibits
    @dmns.add_exhibit(@dead_sea_scrolls)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.exhibits
    @dmns.add_exhibit(@imax)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_recommend_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    assert_equal [@gems_and_minerals], @dmns.recommend_exhibits(@bob)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@bob)
    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_method_admit
    assert_equal [], @dmns.patrons #test initial setup
    @dmns.admit(@bob)
    assert_equal [@bob], @dmns.patrons
    @dmns.admit(@sally)
    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_method_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    expected = {
          @gems_and_minerals => [],
          @dead_sea_scrolls => [],
          @imax => []
          }
    assert_equal expected, @dmns.patrons_by_exhibit_interest #test with no patrons

    @dmns.admit(@bob)

    expected2 = {
      @gems_and_minerals => [@bob],
      @dead_sea_scrolls => [@bob],
      @imax => []
      }
    assert_equal expected2, @dmns.patrons_by_exhibit_interest

    @dmns.admit(@sally)

    expected3 = {
      @gems_and_minerals => [@bob],
      @dead_sea_scrolls => [@bob],
      @imax => [@sally]
      }
    assert_equal expected3, @dmns.patrons_by_exhibit_interest
  end

end
