import 'package:flutter/material.dart';
import 'package:cafe/models/coffee_item.dart';

class CoffeeDetailPage extends StatelessWidget {
  final CoffeeItem coffeeItem;

  CoffeeDetailPage({required this.coffeeItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coffeeItem.title),
        backgroundColor: Colors.brown[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              coffeeItem.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              coffeeItem.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$${coffeeItem.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            SizedBox(height: 16),
            Text(
              coffeeItem.details,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
