require 'test_helper'

class CalculatorTest < ActiveSupport::TestCase
  should_belong_to :calculable

  context "Calculator" do
    should "respond to .register" do
      assert Calculator.respond_to?(:register)
    end
  end

end
