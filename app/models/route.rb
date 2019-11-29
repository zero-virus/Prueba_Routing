
class Route < ApplicationRecord
  belongs_to :vehicle
  belongs_to :driver

  validates :load_type, inclusion: {in: %w(refrigerada general)}
  validate :validate_load_type, :validate_capacity, on: :create
  validate :validate_stops, :validate_cities, :validate_times_overlap

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

  def validate_times_overlap
    if Routes.exist(driver_id: self.driver_id.to_i) || Routes.exist(vehicle_id: self.vehicle_id.to_i)
        routes_all_driver = Routes.where(driver_id: self.driver_id.to_i)
        routes_all_vehicle = Routes.where(vehicle_id: self.vehicle_id.to_i)
        save_routes = []
        routes_all_driver.each do |route|
            unless (self.start_at..self.ends_at).overlaps?(route.start_at..route.ends_at)
                save_routes << (route)
            end
        end
        routes_all_vehicle.each do |route|
            unless (self.start_at..self.ends_at).overlaps?(route.start_at..route.ends_at)
                save_routes << (route)
            end
        end
        if save_routes != []
            errors.add(:start_at,:ends_at, "The driver or vehicule are not available in this hour")
        end

    end
  end
end
