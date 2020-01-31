class HeadValidator < ActiveModel::Validator
  def validate(record)
    if record.head == true
    	e = Employee.find_by(department: record.department, head: true)
    	if e.present?
    		if e.id != record.id
      		record.errors.add :base, "#{e.names} is already head of the department."
      	end
      end
    end
  end
end
class IdcardValidator < ActiveModel::Validator
  def validate(record)
    if record.idcard.split.join.length != 16
    	record.errors.add :base, "The Idcard's length is incorrect."
    end
    # Id cards in RWANDA must be like "1 YEAR 7 2023 2 23 22"
    # You can only apply for Id card when you're 16 or above so YEAR must be less than DateTime.now.year - 15
    # the number that follows YEAR : 7 means feminine 8 means masculine
    if /\d*(\d{4})[7|8]\d*/.match(record.idcard.split.join)
    	unless (/\d(\d{4})[7|8]\d*/.match(record.idcard.split.join)[1].present?) && (/\d(\d{4})[7|8]\d*/.match(record.idcard.split.join)[1].to_i <= DateTime.now.year.to_i - 15)
	    	record.errors.add :base, "The Idcard's year is incorrect"
	    end
    else
    	record.errors.add :base, "The Idcard's format is incorrect."
    end
  end
end

class Employee < ActiveRecord::Base
	has_many :sessions
	has_many :leaves, class_name: "Leave"
	has_many :attendances
	has_many :documents
	# Names
	validates :names ,presence: { message: 'can not be blank' }
	validates :names, length: { minimum: 5 }
	validates :names, exclusion: { in: %w(admin search chat newcheck send logout edit user signup login signin welcome features index about next),
    message: "%{value} is reserved." }
	# Idcard
	validates :idcard, presence: { message: 'can not be blank' }
	# Email
	validates :email ,presence: { message: 'can not be blank' }
	validates :email, length: { minimum: 6 }
	validates :email, uniqueness: { message: "has already been used" }
	validates :email, format: { with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i,
    message: "is not a valid email" }
	# validates_format_of :email, with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i
	# Password
	validates :password, presence: { message: 'can not be blank' }
	validates :password, length: { minimum: 8 }
	# Password confirmation
	validates :password, confirmation: true
	# Head of Department, only one exist
	validates_with HeadValidator
	# Idcard
	validates_with IdcardValidator
end