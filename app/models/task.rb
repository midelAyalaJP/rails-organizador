# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           not null
#  code        :string
#
class Task < ApplicationRecord
    before_create :create_code
    after_create :send_email
    #pertenece a una categoria
    belongs_to :category

    #relacion usuario
    belongs_to :owner, class_name: 'User'
    has_many :participating_users, class_name: 'Participant'
    has_many :participants, through: :participating_users, source: :user
    has_many :notes


    
    #validaciones
    validates :participating_users, presence: true
    validates :name, :description, presence: true
    validates :name, uniqueness: {case_sensitive: false}
    validate :due_date_validity #validación custom

    accepts_nested_attributes_for :participating_users, allow_destroy: true


   

    #fun del la validacion custom
    def due_date_validity
        return if due_date.blank?
        return if due_date > Date.today
        errors.add :due_date, I18n.t('task.errors.invalid_due_date')
    end


    def create_code
        self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
    end

    def send_email

        #solo para development mode
        return unless Rails.env.development?

        #mandar a participantes y al dueño
        (participants + [owner]).each do |user|

            #self -> mandar la propia tarea que se hizo
            ParticipantMailer.with(user: user, task: self).new_task_email.deliver!
        end

    end
end
