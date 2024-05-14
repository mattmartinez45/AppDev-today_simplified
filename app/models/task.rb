# == Schema Information
#
# Table name: tasks
#
#  id            :integer          not null, primary key
#  category      :string
#  due_date      :date
#  name          :string
#  time_estimate :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
class Task < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id", counter_cache: true
end
