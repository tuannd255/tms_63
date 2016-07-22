class Course < ActiveRecord::Base
  belongs_to :user

  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects

  validates :subjects, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :subjects, allow_destroy: true
  accepts_nested_attributes_for :user_courses, allow_destroy: true

  enum status: [:init, :start, :finish]

  def add_admin_to_course id
    self.update_attributes user_id: id
  end
end
