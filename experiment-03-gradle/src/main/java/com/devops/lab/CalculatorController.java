package com.devops.lab;

import io.swagger.v3.oas.annotations.Parameter;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api/calculator")
public class CalculatorController {
    
    @GetMapping("/add")
    public Map<String, Object> add(
        @Parameter(name = "a", description = "First number") @RequestParam int a,
        @Parameter(name = "b", description = "Second number") @RequestParam int b) {
        int result = a + b;
        Map<String, Object> response = new HashMap<>();
        response.put("operation", "add");
        response.put("a", a);
        response.put("b", b);
        response.put("result", result);
        return response;
    }
    
    @GetMapping("/subtract")
    public Map<String, Object> subtract(
        @Parameter(name = "a", description = "First number") @RequestParam int a,
        @Parameter(name = "b", description = "Second number") @RequestParam int b) {
        int result = a - b;
        Map<String, Object> response = new HashMap<>();
        response.put("operation", "subtract");
        response.put("a", a);
        response.put("b", b);
        response.put("result", result);
        return response;
    }
    
    @GetMapping("/multiply")
    public Map<String, Object> multiply(
        @Parameter(name = "a", description = "First number") @RequestParam int a,
        @Parameter(name = "b", description = "Second number") @RequestParam int b) {
        int result = a * b;
        Map<String, Object> response = new HashMap<>();
        response.put("operation", "multiply");
        response.put("a", a);
        response.put("b", b);
        response.put("result", result);
        return response;
    }
    
    @GetMapping("/divide")
    public Map<String, Object> divide(
        @Parameter(name = "a", description = "First number") @RequestParam int a,
        @Parameter(name = "b", description = "Second number") @RequestParam int b) {
        Map<String, Object> response = new HashMap<>();
        response.put("operation", "divide");
        response.put("a", a);
        response.put("b", b);
        if (b == 0) {
            response.put("error", "Cannot divide by zero");
            response.put("result", null);
        } else {
            response.put("result", (double) a / b);
        }
        return response;
    }
}
