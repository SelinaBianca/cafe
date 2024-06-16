import 'package:cafe/Cart.dart';
import 'package:flutter/material.dart';
import 'package:cafe/models/coffee_item.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'coffee_detail_page.dart';
import 'profile_page.dart';
import 'home.dart';
import 'package:cafe/models/coffee_item.dart';

class CoffeeMenuPage extends StatefulWidget {
  @override
  _CoffeeMenuPageState createState() => _CoffeeMenuPageState();
}

class _CoffeeMenuPageState extends State<CoffeeMenuPage> {
  late Future<List<CoffeeItem>> futureMenu;

  @override
  void initState() {
    super.initState();
    futureMenu = fetchMenuFromJson();
  }

  Future<List<CoffeeItem>> fetchMenuFromJson() async {
    try {
      String jsonString =
      await rootBundle.loadString('assets/menu_data.json');
      List<dynamic> jsonData = json.decode(jsonString);
      List<CoffeeItem> menu = jsonData
          .map((data) => CoffeeItem.fromJson(data))
          .toList();
      return menu;
    } catch (e) {
      print('Error fetching menu: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        // Set preferred height for AppBar
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
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<CoffeeItem>>(
        future: futureMenu,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final menu = snapshot.data!;
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return buildGridView(menu);
                } else {
                  return buildListView(menu);
                }
              },
            );
          }
        },
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
                    MaterialPageRoute(builder: (context) => CoffeeMenuPage()),
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

  ListView buildListView(List<CoffeeItem> menu) {
    return ListView.builder(
      itemCount: menu.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          child: ListTile(
            contentPadding: EdgeInsets.all(6),
            leading: Image.asset(
              menu[index].imageUrl,
              width: 100,
              height: 200,
              fit: BoxFit.cover,
            ),
            title: Text(
              menu[index].title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  '\$${menu[index].price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_shopping_cart, color: Colors.black),
                      onPressed: () {
                        // Add to cart functionality
                      },
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.info, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CoffeeDetailPage(coffeeItem: menu[index]),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  GridView buildGridView(List<CoffeeItem> menu) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2 / 3, // Adjusted aspect ratio for better fit
      ),
      itemCount: menu.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoffeeDetailPage(coffeeItem: menu[index]),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  menu[index].imageUrl,
                  width: double.infinity,
                  height: 250, // Increased image size
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Adjusted font size
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${menu[index].price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[400],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart,
                                color: Colors.green[400]),
                            onPressed: () {
                              // Add to cart functionality
                            },
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            icon: Icon(Icons.info, color: Colors.blue[400]),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CoffeeDetailPage(coffeeItem: menu[index]),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],

            ),
          ),
        );
      },
    );
  }
}

