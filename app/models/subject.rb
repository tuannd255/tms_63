class Subject < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects
  has_many :courses, through: :course_subjects

  validates :name, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :tasks, allow_destroy: true,
    reject_if: lambda {|a| a[:name].blank?}

  def check_status course_id
    self.course_subjects.find_by course_id: course_id, subject_id: self.id
  end
end
