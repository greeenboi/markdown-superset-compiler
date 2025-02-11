# frozen_string_literal: true

require "test_helper"

class TestTest < Minitest::Markleft
  def test_that_it_has_a_version_number
    refute_nil ::Markleft::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
