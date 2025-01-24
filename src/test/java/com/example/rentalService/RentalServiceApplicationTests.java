package com.example.rentalService;

import com.example.rentalService.web.Car;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class RentalServiceApplicationTests {

	@Test
	void contextLoads() {
	}

	@Test
	public void test1(){
		Car car = new Car("11AA22", 1000);
		assertEquals(car.getPlateNumber(), "11AA22");
	}

}