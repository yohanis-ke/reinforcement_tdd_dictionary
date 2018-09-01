require 'minitest/autorun'
require 'minitest/pride'
require './dictionary.rb'

class TestDictionary < MiniTest::Test
  def setup
    @entries = Dictionary.new
  end

  def test_empty_on_creation
    assert_empty @entries.entries
  end

  def test_add_entry_with_keyword_and_definition
    @entries.add('fish' => 'aquatic animal')
    assert_equal({'fish' => 'aquatic animal'}, @entries.entries)
    assert_equal ['fish'], @entries.keywords
  end

  def test_add_keywords_without_definition
    @entries.add('fish')
    assert_equal({'fish' => nil}, @entries.entries)
    assert_equal ['fish'], @entries.keywords
  end

  def test_check_if_keyword_exists
    # refute asserts falsy, !assert
    refute @entries.include?('fish')
  end

  def test_check_if_keyword_exists_after_add
    refute @entries.include?('fish') # if the method is empty, this test passes
    @entries.add('fish')
    assert @entries.include?('fish') # confirms that it actually checks
    refute @entries.include?('bird') # confirms not always returning true after add
  end

  def test_does_not_include_prefix
    @entries.add('fish')
    refute @entries.include?('fi')
  end

  def test_does_not_find_word_in_empty_dictionary
    assert_empty @entries.find('fi')
  end

  def test_finds_nothing_if_prefix_matches_nothing
    @entries.add('fiend')
    @entries.add('great')
    assert_empty @entries.find('nothing')
  end

  def test_finds_entry
    @entries.add('fish' => 'aquatic animal')
    assert_equal({'fish' => 'aquatic animal'}, @entries.find('fish'))
  end

  def test_finds_multiple_matches_from_prefix_and_returns_entire_entry
    @entries.add('fish' => 'aquatic animal')
    @entries.add('fiend' => 'wicked person')
    @entries.add('great' => 'remarkable')
    assert_equal({'fish' => 'aquatic animal', 'fiend' => 'wicked person'}, @entries.find('fi'))
  end

  def test_lists_words_alphabetically
    @entries.add('zebra' => 'African land animal with stripes')
    @entries.add('fish' => 'aquatic animal')
    @entries.add('apple' => 'fruit')
    # Enter %w(apple fish zebra) in irb and see what happens
    assert_equal %w(apple fish zebra), @entries.keywords
  end
end
