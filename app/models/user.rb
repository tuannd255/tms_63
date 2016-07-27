class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable,
    :rememberable, :validatable, :registerable

  has_many :activities, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_subjects, dependent: :destroy
  has_many :subjects, through: :user_subjects

  enum role: {trainee: 0, supervisor: 1, admin: 2}

  scope :not_in_course, ->course_id {where "id not in (select user_id
    from user_courses where course_id = ?)", course_id}
  scope :avaiable_user, ->course_id {where "id NOT IN (SELECT user_id FROM
    user_courses WHERE course_id != ? AND (course_id IN (SELECT id FROM
    courses where status = 1 OR status = 0 )))", course_id}
  scope :not_admin, ->{where.not role: 2}

  private
  def password_required?
    new_record? ? super: false
  end
end
