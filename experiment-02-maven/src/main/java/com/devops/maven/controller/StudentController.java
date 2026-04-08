package com.devops.maven.controller;

import com.devops.maven.model.Student;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@RestController
@RequestMapping("/api/students")
@Tag(name = "Student Management", description = "CRUD operations for Student Management System")
public class StudentController {

    private final Map<Long, Student> studentMap = new ConcurrentHashMap<>();
    private final AtomicLong idGenerator = new AtomicLong(1);

    public StudentController() {
        addSampleStudents();
    }

    private void addSampleStudents() {
        studentMap.put(1L, new Student(1L, "John Smith", "john@email.com", "Computer Science", 20, "A"));
        studentMap.put(2L, new Student(2L, "Maria Garcia", "maria@email.com", "Information Technology", 21, "A+"));
        studentMap.put(3L, new Student(3L, "David Chen", "david@email.com", "Software Engineering", 19, "B+"));
        idGenerator.set(4L);
    }

    @GetMapping
    @Operation(summary = "Get all students", description = "Returns list of all students")
    public List<Student> getAllStudents() {
        return new ArrayList<>(studentMap.values());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get student by ID", description = "Returns a single student by ID")
    public ResponseEntity<Student> getStudentById(@PathVariable("id") Long id) {
        Student student = studentMap.get(id);
        if (student != null) {
            return ResponseEntity.ok(student);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping
    @Operation(summary = "Create new student", description = "Adds a new student to the system")
    public Student createStudent(@RequestBody Student student) {
        Long id = idGenerator.getAndIncrement();
        student.setId(id);
        studentMap.put(id, student);
        return student;
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update student", description = "Updates an existing student")
    public ResponseEntity<Student> updateStudent(@PathVariable("id") Long id, @RequestBody Student student) {
        if (studentMap.containsKey(id)) {
            student.setId(id);
            studentMap.put(id, student);
            return ResponseEntity.ok(student);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete student", description = "Removes a student from the system")
    public ResponseEntity<Void> deleteStudent(@PathVariable("id") Long id) {
        if (studentMap.containsKey(id)) {
            studentMap.remove(id);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/search")
    @Operation(summary = "Search students", description = "Search students by name or course")
    public List<Student> searchStudents(@RequestParam("query") String query) {
        String lowerQuery = query.toLowerCase();
        return studentMap.values().stream()
            .filter(s -> s.getName().toLowerCase().contains(lowerQuery) || 
                        s.getCourse().toLowerCase().contains(lowerQuery))
            .toList();
    }
}
