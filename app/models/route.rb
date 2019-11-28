class Route < ApplicationRecord
  belongs_to :vehicle
  belongs_to :driver

  validates :load_type, inclusion: {in: %w(refrigerada general)}
  validate :validate_load_type, :validate_capacity, on: :create
  def validate_load_type
    vehicle = Vehicle.find(self.vehicle_id.to_s)
    if vehicle.load_type != self.load_type
      errors.add(:load_type, "This vehicle can't load this type of object ")
    end
  end

  def validate_capacity
    vehicle = Vehicle.find_by(self.vehicle_id.to_s)
    if vehicle.capacity < self.load_sum
        errors.add(:capacity, "Exceeds maximum capacity")
    end
  end
