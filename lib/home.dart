import 'package:cafe/profile_page.dart';
import 'package:flutter/material.dart';
import 'coffee_menu.dart';
import 'Cart.dart';
import 'coffee.dart';
import 'cake.dart';
import 'pasta.dart';
import 'pizza.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0), // Set preferred height for AppBar
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: AppBar(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30), // Circular bottom edge
              ),
            ),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Text(
                  "Coffee & Co.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 45.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.black54),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        border: InputBorder.none,
                      ),
                      onTap: () {
                        // Navigate to search page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(context, 'assets/coffee_icon.jpg', 'Coffee', CoffeePage()),
                _buildIconButton(context, 'assets/pasta_icon.jpg', 'Pasta', PastaPage()),
                _buildIconButton(context, 'assets/pizza_icon.jpg', 'Pizza', PizzaPage()),
                _buildIconButton(context, 'assets/cake_icon.jpg', 'Cake', CakePage()),
              ],
            ),
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Popular Items',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            _buildPopularItems(),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Personal Favourites',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,

                ),
              ),

            ),
            SizedBox(height: 30.0),
            _buildFavouriteItems(),
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
                  // Navigate to home
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.restaurant_menu, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  CoffeeMenuPage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, String iconPath, String label, Widget pageToNavigate) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pageToNavigate),
            );
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(iconPath),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }

  Widget _buildPopularItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildItemCard('Creamy Latte', '\$5.00', 'assets/latte.jpg'),
          _buildItemCard('Sea Food Pasta', '\$18.99', 'assets/pasta_image.jpg'),
          _buildItemCard('Peperoni Pizza', '\$10.99', 'assets/pizza_image.jpg'),
          _buildItemCard('Cheese Cake', '\$6.00', 'assets/cake_image.jpeg'),
        ],
      ),
    );
  }

  Widget _buildFavouriteItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildItemCard('Machiatto', '\$5.00', 'assets/macchiato.jpg'),
          _buildItemCard('Affogato', '\$5.00', 'assets/affogata.jpg'),
          _buildItemCard('Peperoni Pizza', '\$10.99', 'assets/pizza_image.jpg'),
          _buildItemCard('Brownies', '\$7.00', 'assets/brownies.jpg'),
        ],
      ),
    );
  }

  Widget _buildItemCard(String name, String price, String imagePath) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image.asset(
                imagePath,
                height: 150,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,

                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(
        child: Text('Search Page'),
      ),
    );
  }
}



void main() {
  runApp(MaterialApp(home: HomePage()));
}
