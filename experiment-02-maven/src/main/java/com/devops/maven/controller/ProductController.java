package com.devops.maven.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@RestController
@RequestMapping("/api/products")
@Tag(name = "Product Management", description = "Product inventory management system")
public class ProductController {

    private final Map<Long, Map<String, Object>> productMap = new ConcurrentHashMap<>();
    private final AtomicLong idGenerator = new AtomicLong(1);

    public ProductController() {
        addSampleProducts();
    }

    private void addSampleProducts() {
        Map<String, Object> p1 = new HashMap<>();
        p1.put("id", 1L);
        p1.put("name", "Laptop");
        p1.put("category", "Electronics");
        p1.put("price", 999.99);
        p1.put("stock", 50);
        p1.put("available", true);
        productMap.put(1L, p1);

        Map<String, Object> p2 = new HashMap<>();
        p2.put("id", 2L);
        p2.put("name", "Smartphone");
        p2.put("category", "Electronics");
        p2.put("price", 699.99);
        p2.put("stock", 100);
        p2.put("available", true);
        productMap.put(2L, p2);

        Map<String, Object> p3 = new HashMap<>();
        p3.put("id", 3L);
        p3.put("name", "Textbook");
        p3.put("category", "Books");
        p3.put("price", 49.99);
        p3.put("stock", 25);
        p3.put("available", true);
        productMap.put(3L, p3);

        idGenerator.set(4L);
    }

    @GetMapping
    @Operation(summary = "Get all products", description = "Returns list of all products")
    public List<Map<String, Object>> getAllProducts() {
        return new ArrayList<>(productMap.values());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get product by ID", description = "Returns product details")
    public ResponseEntity<Map<String, Object>> getProduct(@PathVariable("id") Long id) {
        if (productMap.containsKey(id)) {
            return ResponseEntity.ok(productMap.get(id));
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping
    @Operation(summary = "Add new product", description = "Adds new product to inventory")
    public Map<String, Object> createProduct(@RequestBody Map<String, Object> product) {
        Long id = idGenerator.getAndIncrement();
        product.put("id", id);
        productMap.put(id, product);
        return product;
    }

    @PutMapping("/{id}/stock")
    @Operation(summary = "Update stock", description = "Update product stock quantity")
    public ResponseEntity<Map<String, Object>> updateStock(
            @PathVariable("id") Long id,
            @Parameter(name = "quantity", description = "Stock quantity") @RequestParam("quantity") int quantity) {
        if (productMap.containsKey(id)) {
            Map<String, Object> product = productMap.get(id);
            product.put("stock", quantity);
            product.put("available", quantity > 0);
            return ResponseEntity.ok(product);
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/category/{category}")
    @Operation(summary = "Get products by category")
    public List<Map<String, Object>> getProductsByCategory(@PathVariable("category") String category) {
        return productMap.values().stream()
            .filter(p -> p.get("category").toString().equalsIgnoreCase(category))
            .toList();
    }
}
