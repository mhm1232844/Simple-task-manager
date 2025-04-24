# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  # Test validations using shoulda-matchers
  describe 'validations' do
    subject { build(:task) } # Use a factory for the subject
    it { should validate_presence_of(:title) }
  end

  # Test default values
  describe 'defaults' do
    it "is incomplete by default" do
      task = build(:task)
      expect(task.completed).to be false
    end
  end

  # Test instance methods
  describe '#status' do
    it "returns 'Incomplete' when completed is false" do
      task = build(:task, :incomplete) # Use trait
      expect(task.status).to eq('Incomplete')
    end

    it "returns 'Complete' when completed is true" do
      task = build(:task, :completed) # Use trait
      expect(task.status).to eq('Complete')
    end
  end
end