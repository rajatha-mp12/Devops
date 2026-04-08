package com.devops.lab;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class CalculatorTest {
    private final Calculator calc = new Calculator();

    @Test void testAdd()      { assertEquals(8,  calc.add(5, 3)); }
    @Test void testSubtract() { assertEquals(6,  calc.subtract(10, 4)); }
    @Test void testMultiply() { assertEquals(42, calc.multiply(6, 7)); }
    @Test void testDivide()   { assertEquals(5.0, calc.divide(15, 3)); }
    @Test void testDivideByZero() {
        assertThrows(ArithmeticException.class, () -> calc.divide(10, 0));
    }
}
