SELECT restaurant_name, address, rating
FROM restaurants
WHERE (district = 'Quận 1' OR district = 'Quận 3') AND Rating > 4.0;