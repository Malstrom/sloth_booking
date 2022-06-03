require "test_helper"

class SlotTest < ActiveSupport::TestCase
  def setup
    @slot = Slot.new(gametable: Gametable.first, time: "14:00".to_time, price: 400, state: :open)
  end

  test 'valid user' do
    assert @slot.valid?
  end

  test 'invalid without name' do
    @slot.gametable = nil
    refute @slot.valid?, 'saved user without a gametable'
    assert_not_nil @slot.errors[:gametable], 'no validation error for gametable present'
  end

  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?
    assert_not_nil @user.errors[:email]
  end

end
