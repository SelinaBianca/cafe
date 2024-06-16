import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';
import 'profile_page.dart';
import 'coffee_menu.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _locationMessage = '';
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;

  List<CartItem> cartItems = [
    CartItem(
      title: 'Espresso',
      description: 'Strong and bold espresso',
      price: 2.50,
      imageUrl: 'assets/espresso.jpg',
    ),
    CartItem(
      title: 'Cappuccino',
      description: 'Rich and creamy cappuccino',
      price: 3.50,
      imageUrl: 'assets/macchiato.jpg',
    ),
    CartItem(
      title: 'Latte',
      description: 'Smooth and mild latte',
      price: 4.00,
      imageUrl: 'assets/latte.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _locationMessage = 'Fetching location...';
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _locationMessage =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        _fetchWeather(position.latitude, position.longitude);
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error fetching location: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchWeather(double lat, double lon) async {
    final apiKey = 'c23f93fc0cd6dd8c62abdef78f5e7665';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _weatherData = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      setState(() {
        _locationMessage = 'Error fetching weather: $e';
        _isLoading = false;
      });
    }
  }

  double _calculateTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: AppBar(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Text(
                  'Cart',
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
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : _weatherData == null
                  ? Text(_locationMessage)
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WeatherWidget(weatherData: _weatherData!),
                  SizedBox(height: 20),
                  DeliveryStatusWidget(weatherData: _weatherData!),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          Expanded(
            flex: 3,
            child: ListView(
              children: cartItems.map((item) => CartItemWidget(item: item)).toList(),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Grand Total: \$${_calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CartPage()));
                },
              ),
              IconButton(
                icon: Icon(Icons.restaurant_menu, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CoffeeMenuPage()));
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherWidget({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final location = weatherData['name'];
    final temperature = weatherData['main']['temp'];
    final weatherDescription = weatherData['weather'][0]['description'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Location: $location',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 10),
        Text(
          'Temperature: $temperature °C',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 10),
        Text(
          'Weather: $weatherDescription',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class DeliveryStatusWidget extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  DeliveryStatusWidget({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final weatherDescription = weatherData['weather'][0]['main'];
    bool canDeliver = weatherDescription != 'Rain' && weatherDescription != 'Snow';

    return Text(
      canDeliver ? 'Delivery Possible' : 'Delivery Not Possible',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: canDeliver ? Colors.green : Colors.red,
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  CartItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ListTile(
        leading: Image.asset(item.imageUrl, width: 50, fit: BoxFit.cover),
        title: Text(item.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(item.description),
        trailing: Text('\$${item.price.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }
}

class CartItem {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  CartItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}
