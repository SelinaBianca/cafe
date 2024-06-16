import 'Cart.dart';
import 'home.dart';
import 'profile_page.dart';
import 'coffee_menu.dart';
import 'package:flutter/material.dart';

class CoffeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee at Coffee & Co.'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu Items',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            // Sample Card
            Expanded(
              child: ListView(
                children: [
                  _buildMenuCard('Creamy Latte', '\$5.00', 'assets/latte.jpg', 'Coffee'),
                  _buildMenuCard('Espresso', '\$6.00', 'assets/espresso.jpg', 'Coffee'),
                  _buildMenuCard('Iced Latte', '\$5.00', 'assets/coffee_main.png', 'Coffee'),
                  _buildMenuCard('Affogato', '\$5.00', 'assets/affogata.jpg', 'Coffee'),
                  _buildMenuCard('Macchiato', '\$5.00', 'assets/macchiato.jpg', 'Coffee'),
                  _buildMenuCard('Mocha', '\$5.00', 'assets/mocha.jpg', 'Coffee'),
                  _buildMenuCard('Irish Coffee', '\$5.00', 'assets/irish.jpg', 'Coffee'),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                },
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()),);
                },
              ),
              IconButton(
                icon: Icon(Icons.restaurant_menu, color: Colors.white),
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => CoffeeMenuPage()),);
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle, color: Colors.white),
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()),);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(String itemName, String price, String imagePath, String category) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.grey,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {

                        },
                      ),
                      Text('1'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    // Handle adding to cart
                  },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
