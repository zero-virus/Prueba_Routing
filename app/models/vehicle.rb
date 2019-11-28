class Vehicle < ApplicationRecord
    has_many :routes
    belongs_to :driver
end
