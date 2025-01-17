package com.example.rentalService.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/rentals")
public class RentalWebService {

    private Map<String, Rental> rentals = new HashMap<>();

    Logger logger  = LoggerFactory.getLogger(RentalWebService.class);
    @PutMapping("/{plateNumber}")
    @ResponseStatus(HttpStatus.OK)
    public void rentOrReturnCar(
            @PathVariable("plateNumber") String plateNumber,
            @RequestParam(value = "rent", required = true) boolean rent,
            @RequestBody(required = false) Dates dates) throws Exception {

        logger.info("Plate Number "+ plateNumber);
        logger.info("Dates" + dates);
        logger.info("rent"+ rent);

        if (rent) {
            if (rentals.containsKey(plateNumber)) {
                throw new Exception("Car is already rented");
            }
            rentals.put(plateNumber, new Rental(plateNumber, dates.begin, dates.end));
        } else {
            rentals.remove(plateNumber);
        }
    }
}
