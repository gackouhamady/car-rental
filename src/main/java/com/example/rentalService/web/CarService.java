package com.example.rentalService.web;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.example.rentalService.web.Car;
import com.example.rentalService.web.Rental;
import com.example.rentalService.web.Dates;


@RestController
@RequestMapping("/cars")
public class CarService {

    private Map<String, Car> cars = new HashMap<>();

    public CarService() {
        cars.put("11AA22", new Car("11AA22", "Ferrari", 100));
        cars.put("33BB44", new Car("33BB44", "Porsche", 80));
    }

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<Car> listOfCars() {
        return new ArrayList<>(cars.values());
    }

    @GetMapping("/{plateNumber}")
    @ResponseStatus(HttpStatus.OK)
    public Car getCar(@PathVariable("plateNumber") String plateNumber) throws Exception {
        Car car = cars.get(plateNumber);
        if (car == null) {
            throw new Exception("Car not found");
        }
        return car;
    }

    @GetMapping("/available")
    @ResponseStatus(HttpStatus.OK)
    public List<Car> getAvailableCars() {
        return new ArrayList<>(cars.values());
    }
}
