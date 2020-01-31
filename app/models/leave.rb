class FutureValidator < ActiveModel::Validator
  def validate(record)
    if record.new_record?
      if options[:fields].any?{|field| record.send(field) < DateTime.now }
        record.errors.add :base, "The leave's start time and it's end time must be in future."
      end
    end
  end
end

class GreaterValidator < ActiveModel::Validator
  def validate(record)
    if record.end < record.start
      record.errors.add :base, "The leave's end date must be after it's start date."
    end
    if record.expected < record.end
      record.errors.add :base, "The date you are expected to be in office must be after the date your leave ends."
    end
  end
end

class Leave < ApplicationRecord
  belongs_to :employee

  validates :reason, :start, :end, presence: true
  validates :reason, length: { in: 4..100 }
  validates_with FutureValidator, fields: [:start, :end]
  validates_with GreaterValidator
end