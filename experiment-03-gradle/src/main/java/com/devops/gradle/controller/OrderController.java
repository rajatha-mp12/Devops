package com.devops.gradle.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@RestController
@RequestMapping("/api/orders")
@Tag(name = "Order Management", description = "E-commerce Order Management System")
public class OrderController {

    private final Map<Long, Map<String, Object>> orderMap = new ConcurrentHashMap<>();
    private final AtomicLong idGenerator = new AtomicLong(1);

    public OrderController() {
        addSampleOrders();
    }

    private void addSampleOrders() {
        Map<String, Object> o1 = new HashMap<>();
        o1.put("id", 1L);
        o1.put("customerName", "Emma Wilson");
        o1.put("product", "Laptop");
        o1.put("quantity", 2);
        o1.put("totalPrice", 1999.98);
        o1.put("status", "Delivered");
        o1.put("orderDate", "2026-04-01");
        orderMap.put(1L, o1);

        Map<String, Object> o2 = new HashMap<>();
        o2.put("id", 2L);
        o2.put("customerName", "Frank Miller");
        o2.put("product", "Smartphone");
        o2.put("quantity", 1);
        o2.put("totalPrice", 699.99);
        o2.put("status", "Shipped");
        o2.put("orderDate", "2026-04-05");
        orderMap.put(2L, o2);

        Map<String, Object> o3 = new HashMap<>();
        o3.put("id", 3L);
        o3.put("customerName", "Grace Lee");
        o3.put("product", "Headphones");
        o3.put("quantity", 3);
        o3.put("totalPrice", 149.97);
        o3.put("status", "Processing");
        o3.put("orderDate", "2026-04-06");
        orderMap.put(3L, o3);

        idGenerator.set(4L);
    }

    @GetMapping
    @Operation(summary = "Get all orders", description = "Returns all orders")
    public List<Map<String, Object>> getAllOrders() {
        return new ArrayList<>(orderMap.values());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get order by ID", description = "Returns order details")
    public ResponseEntity<Map<String, Object>> getOrder(@PathVariable Long id) {
        if (orderMap.containsKey(id)) {
            return ResponseEntity.ok(orderMap.get(id));
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping
    @Operation(summary = "Create new order", description = "Places new order")
    public Map<String, Object> createOrder(@RequestBody Map<String, Object> order) {
        Long id = idGenerator.getAndIncrement();
        order.put("id", id);
        orderMap.put(id, order);
        return order;
    }

    @PutMapping("/{id}/status")
    @Operation(summary = "Update order status", description = "Updates order status")
    public ResponseEntity<Map<String, Object>> updateStatus(
            @PathVariable Long id,
            @Parameter(name = "status", description = "Order status") @RequestParam("status") String status) {
        if (orderMap.containsKey(id)) {
            Map<String, Object> order = orderMap.get(id);
            order.put("status", status);
            return ResponseEntity.ok(order);
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/status/{status}")
    @Operation(summary = "Get orders by status")
    public List<Map<String, Object>> getOrdersByStatus(@PathVariable String status) {
        return orderMap.values().stream()
            .filter(o -> o.get("status").toString().equalsIgnoreCase(status))
            .toList();
    }
}
