# app/models/task.rb
class Task < ApplicationRecord
  # Validations
  validates :title, presence: true

  # Scopes (optional but good practice)
  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  scope :ordered_by_creation_desc, -> { order(created_at: :desc) }

  # Instance Methods
  def status
    completed? ? 'Complete' : 'Incomplete'
  end
end