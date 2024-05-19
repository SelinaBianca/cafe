// import 'package:flutter/material.dart';
// import 'package:cafe/models/coffee_item.dart';
// import 'package:flutter/services.dart' show rootBundle; // Import rootBundle
// import 'dart:convert';
//
// class CoffeeMenuPage extends StatefulWidget {
//   @override
//   _CoffeeMenuPageState createState() => _CoffeeMenuPageState();
// }
//
// class _CoffeeMenuPageState extends State<CoffeeMenuPage> {
//   late Future<List<CoffeeItem>> futureMenu;
//
//   @override
//   void initState() {
//     super.initState();
//     futureMenu = fetchMenuFromJson(); // Load menu data from JSON file
//   }
//
//   Future<List<CoffeeItem>> fetchMenuFromJson() async {
//     try {
//       // Load JSON data from file
//       String jsonString = await rootBundle.loadString('assets/menu_data.json');
//       // Parse JSON data into list of CoffeeItem objects
//       List<dynamic> jsonData = json.decode(jsonString);
//       List<CoffeeItem> menu = jsonData.map((data) => CoffeeItem.fromJson(data)).toList();
//       return menu;
//     } catch (e) {
//       // Handle error
//       print('Error fetching menu: $e');
//       return []; // Return an empty list or show an error message
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Coffee Menu',
//           style: TextStyle(
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.brown[800], // Dark brown color for app bar
//       ),
//       body: Container(
//         color: Colors.grey[200], // Light grey background color
//         child: FutureBuilder<List<CoffeeItem>>(
//           future: futureMenu,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(child: Text('No data available'));
//             } else {
//               final menu = snapshot.data!;
//               return ListView.builder(
//                 itemCount: menu.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     elevation: 4,
//                     child: ListTile(
//                       contentPadding: EdgeInsets.all(16),
//                       title: Text(
//                         menu[index].title,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 8),
//                           Text(
//                             menu[index].description,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             '\$${menu[index].price.toStringAsFixed(2)}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                               color: Colors.green[900], // Dark green color for price
//                             ),
//                           ),
//                         ],
//                       ),
//                       leading: Image.asset(
//                         menu[index].imageUrl,
//                         width: 80,
//                         height: 80,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cafe/models/coffee_item.dart';
import 'package:flutter/services.dart' show rootBundle; // Import rootBundle
import 'dart:convert';
import 'coffee_detail_page.dart';

class CoffeeMenuPage extends StatefulWidget {
  @override
  _CoffeeMenuPageState createState() => _CoffeeMenuPageState();
}

class _CoffeeMenuPageState extends State<CoffeeMenuPage> {
  late Future<List<CoffeeItem>> futureMenu;

  @override
  void initState() {
    super.initState();
    futureMenu = fetchMenuFromJson(); // Load menu data from JSON file
  }

  Future<List<CoffeeItem>> fetchMenuFromJson() async {
    try {
      // Load JSON data from file
      String jsonString = await rootBundle.loadString('assets/menu_data.json');
      // Parse JSON data into list of CoffeeItem objects
      List<dynamic> jsonData = json.decode(jsonString);
      List<CoffeeItem> menu = jsonData.map((data) => CoffeeItem.fromJson(data)).toList();
      return menu;
    } catch (e) {
      // Handle error
      print('Error fetching menu: $e');
      return []; // Return an empty list or show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Menu'),
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
    );
  }

  ListView buildListView(List<CoffeeItem> menu) {
    return ListView.builder(
      itemCount: menu.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(
              menu[index].title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  menu[index].description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  '\$${menu[index].price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green[900], // Dark green color for price
                  ),
                ),
              ],
            ),
            leading: Image.asset(
              menu[index].imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoffeeDetailPage(coffeeItem: menu[index]),
                ),
              );
            },
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
        childAspectRatio: 3 / 2,
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
            elevation: 4,
            child: Column(
              children: [
                Image.asset(
                  menu[index].imageUrl,
                  width: double.infinity,
                  height: 100,
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
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '\$${menu[index].price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
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