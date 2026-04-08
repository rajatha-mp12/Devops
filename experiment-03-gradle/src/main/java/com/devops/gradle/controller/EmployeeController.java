package com.devops.gradle.controller;

import com.devops.gradle.model.Employee;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@RestController
@RequestMapping("/api/employees")
@Tag(name = "Employee Management", description = "HR Management System - Employee Records")
public class EmployeeController {

    private final Map<Long, Employee> employeeMap = new ConcurrentHashMap<>();
    private final AtomicLong idGenerator = new AtomicLong(1);

    public EmployeeController() {
        addSampleEmployees();
    }

    private void addSampleEmployees() {
        employeeMap.put(1L, new Employee(1L, "Alice Johnson", "alice@company.com", "Engineering", 75000.00, "Senior Developer"));
        employeeMap.put(2L, new Employee(2L, "Bob Williams", "bob@company.com", "Marketing", 55000.00, "Marketing Manager"));
        employeeMap.put(3L, new Employee(3L, "Carol Davis", "carol@company.com", "HR", 65000.00, "HR Manager"));
        employeeMap.put(4L, new Employee(4L, "Daniel Brown", "daniel@company.com", "Finance", 80000.00, "Financial Analyst"));
        idGenerator.set(5L);
    }

    @GetMapping
    @Operation(summary = "Get all employees", description = "Returns list of all employees")
    public List<Employee> getAllEmployees() {
        return new ArrayList<>(employeeMap.values());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get employee by ID", description = "Returns employee details by ID")
    public ResponseEntity<Employee> getEmployeeById(@PathVariable Long id) {
        Employee employee = employeeMap.get(id);
        if (employee != null) {
            return ResponseEntity.ok(employee);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping
    @Operation(summary = "Add new employee", description = "Creates new employee record")
    public Employee createEmployee(@RequestBody Employee employee) {
        Long id = idGenerator.getAndIncrement();
        employee.setId(id);
        employeeMap.put(id, employee);
        return employee;
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update employee", description = "Updates employee information")
    public ResponseEntity<Employee> updateEmployee(@PathVariable Long id, @RequestBody Employee employee) {
        if (employeeMap.containsKey(id)) {
            employee.setId(id);
            employeeMap.put(id, employee);
            return ResponseEntity.ok(employee);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete employee", description = "Removes employee from system")
    public ResponseEntity<Void> deleteEmployee(@PathVariable Long id) {
        if (employeeMap.containsKey(id)) {
            employeeMap.remove(id);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/department/{department}")
    @Operation(summary = "Get employees by department")
    public List<Employee> getEmployeesByDepartment(@PathVariable String department) {
        return employeeMap.values().stream()
            .filter(e -> e.getDepartment().equalsIgnoreCase(department))
            .toList();
    }

    @GetMapping("/search")
    @Operation(summary = "Search employees", description = "Search by name or designation")
    public List<Employee> searchEmployees(@RequestParam String query) {
        String lowerQuery = query.toLowerCase();
        return employeeMap.values().stream()
            .filter(e -> e.getName().toLowerCase().contains(lowerQuery) ||
                        e.getDesignation().toLowerCase().contains(lowerQuery))
            .toList();
    }
}
