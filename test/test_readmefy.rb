require 'test/unit'
require 'readmefy'

class ReadmefyTest < Test::Unit::TestCase
  def test_test
    assert Readmefy.recurse.include? 'test'
    assert Readmefy.recurse.include? 'lib'
    assert Readmefy.recurse.include? 'bin'
  end
end
