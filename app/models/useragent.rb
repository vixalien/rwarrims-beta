class Useragent < ApplicationRecord
  belongs_to :ua, polymorphic: true
end
