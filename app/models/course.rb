class Course < ActiveRecord::Base
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects

  validates :subjects, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :subjects, allow_destroy: true

  enum status: {init: 0, start: 1, finish: 2}
end
