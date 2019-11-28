class Route < ApplicationRecord
  belongs_to :vehicle
  belongs_to :driver

  validates :load_type, inclusion: {in: %w(refrigerada general)}
  validate :validate_load_type, :validate_capacity, on: :create
  validate :validate_stops, :validate_cities, on: :create# , :validate_times_overlap

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

  def validate_stops
    driver = Driver.find_by(self.driver_id.to_s)
    if driver.max_stops < self.stop_amount
        errors.add(:stop_amount, "To many stops for this driver")
    end
  end

  def validate_cities
    driver = Driver.find(self.driver_id)
    unless (self.cities.lines.to_a - driver.cities.lines.to_a).empty?
        errors.add(:cities, "The driver don't go to that city")
    end
  end
