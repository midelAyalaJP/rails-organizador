# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
    #tiene muchas tareas
    has_many :tasks

    #validaciones
    validates :name, :description, presence: true
    validates :name, uniqueness: {case_sensitive: false}
end
