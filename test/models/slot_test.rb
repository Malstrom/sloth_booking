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

  test 'invalid state if date in past' do
    slot = slots(:yesterday_slot)

    slot.update_attribute(:state, :close)
    assert_not slot.valid?
  end

  test 'valid state if date in future' do
    slot = slots(:tomorrow_slot)

    slot.update_attribute(:state, :close)
    assert slot.valid?
  end

  test 'price display value empty slot' do
    slot = slots(:today_slot)

    assert slot.display_value == slot.price
  end

  test 'trainer display value and color for trainings' do
    slot = slots(:training_slot)
    training = trainings(:first_training)

    assert slot.display_value == training.trainer
    assert slot.define_color == "cell-color-training"
  end

  test 'rating display value and color for tournaments' do
    slot = slots(:tournament_slot)
    tournament = tournaments(:first_tournament)

    assert slot.display_value == "< " + tournament.rating.to_s
    assert slot.define_color == "cell-color-tournament"
  end

  test 'display colors for slot' do
    slot_300 = slots(:slot_price_300)
    slot_450 = slots(:slot_price_450)
    slot_600 = slots(:slot_price_600)
    slot_750 = slots(:slot_price_750)
    slot_3000 = slots(:slot_price_3000)
    slot_3001 = slots(:slot_price_3001)

    assert slot_300.define_color == "cell-color-yellow"
    assert slot_450.define_color == "cell-color-blue"
    assert slot_600.define_color == "cell-color-green"
    assert slot_750.define_color == "cell-color-pink"
    assert slot_3000.define_color == "cell-color-purple"
    assert slot_3001.define_color == "cell-color-yellow"
  end

  test 'generate slots for empty day' do
    club = clubs(:sokol)
    day = 1.months.after

    gametables = Slot.generate_slots(day, club.id)
    p gametables.last.slots.count
    
    assert gametables.last.slots.count == 48
  end

  test 'update valid working date' do
    club = clubs(:sokol)
    selected_day = 1.months.after
    hour_to_add = 4
    starts_at = "14:00".to_time + 1.months
    ends_at = starts_at + hour_to_add.hours

    Slot.generate_slots(selected_day, club.id)
    Slot.update_working_date(club, selected_day, starts_at, ends_at)

    assert Slot.by_club(club).open_slot.group_by_day_hours(selected_day).count == 8
  end

  test 'update invalid working date' do
    club = clubs(:sokol)
    selected_day = 1.months.ago
    hour_to_add = 4
    starts_at = "14:00".to_time - 1.months
    ends_at = starts_at + hour_to_add.hours

    Slot.generate_slots(selected_day, club.id)
    Slot.update_working_date(club, selected_day, starts_at, ends_at)

    assert Slot.by_club(club).open_slot.group_by_day_hours(selected_day).count != hour_to_add
  end

  test 'deny update working time for booked slot' do
    club = clubs(:sokol)
    selected_day = 1.months.after
    hour_to_add = 4
    starts_at = "14:00".to_time + 1.months
    ends_at = starts_at + hour_to_add.hours

    gametables = Slot.generate_slots(selected_day, club.id)
    gametables.last.slots.open_slot.first.update(:bookable_id => Training.first.id, :bookable_type => "Training")
    Slot.update_working_date(club, selected_day, starts_at, ends_at)

    assert Slot.by_club(club).open_slot.group_by_day_hours(selected_day).count != hour_to_add + 1
  end

end
