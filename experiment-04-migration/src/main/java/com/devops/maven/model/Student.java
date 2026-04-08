package com.devops.maven.model;

public class Student {
    private Long id;
    private String name;
    private String email;
    private String course;
    private int age;
    private String grade;

    public Student() {}

    public Student(Long id, String name, String email, String course, int age, String grade) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.course = course;
        this.age = age;
        this.grade = grade;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }
}
