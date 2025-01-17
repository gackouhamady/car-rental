package com.example.rentalService.web;

public class Rental {
    public Car car;
    public String beginDate;
    public String endDate;

    public Rental(String plateNumber, String beginDate, String endDate) {
        this.car = new Car(plateNumber, "", 0);
        this.beginDate = beginDate;
        this.endDate = endDate;
    }
}
