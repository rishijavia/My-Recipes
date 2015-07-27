require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(name: "john", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chef name should be present" do
    @chef.name = " "
    assert_not @chef.valid?
  end
  
  test "chef name should not be too long" do
    @chef.name = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chef name should not be too short" do
    @chef.name = "aa"
    assert_not @chef.valid?
  end
  
  test "email must be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email length should be not too long" do
    @chef.email = "a" * 100 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid emails" do
    valid_email = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    valid_email.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end
  
  test "email validation should reject invalid emails" do
    invalid_email = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@eee+aar.com]
    invalid_email.each do |inva|
      @chef.email = inva
      assert_not @chef.valid? '#{inva.inspect} should be invalid'
    end
  end
  
end