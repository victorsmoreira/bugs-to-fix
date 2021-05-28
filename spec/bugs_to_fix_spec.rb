# frozen_string_literal: true

require_relative '../app/bugs_to_fix'

describe 'For Bugs:' do
  describe 'when critical' do
    before(:all) do
      @bug_records = [
        { 'id' => 2, 'title' => 'Bug #2 - dued', 'age' => 2, 'priority' => 'Critical' },
        { 'id' => 6, 'title' => 'Bug #6 - expires today', 'age' => 1, 'priority' => 'Critical' },
        { 'id' => 18, 'title' => 'Bug #18 - expires today', 'age' => 1, 'priority' => 'Critical' }
      ]
    end
    context 'and 1 day old' do
      it 'then fix today' do
        selected_bugs = bugs_to_fix(@bug_records)
        expect(selected_bugs[:fix_today].count).to eq(2)
      end
    end

    context 'and older then 1 day' do
      it 'then dued' do
        selected_bugs = bugs_to_fix(@bug_records)
        expect(selected_bugs[:expired].count).to eq(1)
      end
    end
  end

  describe 'when regular' do
    before(:all) do
      @bug_records = [
        { 'id' => 4, 'title' => 'Bug #4 - expires today', 'age' => 3, 'priority' => 'Regular' },
        { 'id' => 7, 'title' => 'Bug #7 - within time', 'age' => 2, 'priority' => 'Regular' },
        { 'id' => 9, 'title' => 'Bug #9 - dued', 'age' => 4, 'priority' => 'Regular' },
        { 'id' => 15, 'title' => 'Bug #15 - within time', 'age' => 1, 'priority' => 'Regular' },
        { 'id' => 16, 'title' => 'Bug #16 - expires today', 'age' => 3, 'priority' => 'Regular' },
        { 'id' => 19, 'title' => 'Bug #19 - dued', 'age' => 4, 'priority' => 'Regular' },
        { 'id' => 29, 'title' => 'Bug #29 - expires today', 'age' => 3, 'priority' => 'Regular' }
      ]
    end
    context 'and 3 days old' do
      it 'then expires today' do
        selected_bugs = bugs_to_fix(@bug_records)
        expect(selected_bugs[:fix_today].count).to eq(3)
      end
    end

    context 'and older then 3 days' do
      it 'then dued' do
        selected_bugs = bugs_to_fix(@bug_records)
        expect(selected_bugs[:expired].count).to eq(2)
      end
    end
  end

  describe 'when no bugs for today' do
    before(:all) do
      @bug_records = [
        { 'id' => 7, 'title' => 'Bug #7 - within time', 'age' => 2, 'priority' => 'Regular' },
        { 'id' => 15, 'title' => 'Bug #15 - within time', 'age' => 1, 'priority' => 'Regular' }
      ]
    end
    it 'then returns empty array' do
      selected_bugs = bugs_to_fix(@bug_records)
      expect(selected_bugs[:fix_today].count).to eq(0)
      expect(selected_bugs[:expired].count).to eq(0)
    end
  end
end
