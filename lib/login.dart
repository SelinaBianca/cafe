// import 'package:flutter/material.dart';
// import 'package:cafe/register.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
//
//
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login Page',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: LoginPage(),
//     );
//   }
// }
//
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 40.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//
//             children: [
//
//               Image.asset(
//                 'assets/background_image.png',
//                 width: 250,
//                 height: 300,
//
//               ),
//
//
//               // Email Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 20.0),
//
//               // Password Field
//               TextFormField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//
//               SizedBox(height: 10.0),
//               Row(
//                 children: [
//                   Text(
//                     'Forgot Password?',
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 40.0),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Login Button
//                   ElevatedButton(
//                     onPressed: () {
//
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => RegisterPage()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.black,
//                       onPrimary: Colors.white,
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     ),
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//
//                   // Register Button
//                   ElevatedButton(
//                     onPressed: () {
//
//                       //Navigator.push(
//                       //  context,
//                        // MaterialPageRoute(builder: (context) => HomePage()),
//                      //);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.black,
//                       onPrimary: Colors.white,
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     ),
//                     child: Text(
//                       'Sign In',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe/coffee_menu.dart'; // Import main.dart where CoffeeMenuPage is defined

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/logo.png'), // Replace 'assets/logo.png' with the path to your logo image
              ),
              SizedBox(height: 20),

              // Email Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 50.0),

              // Password Field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 50.0),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                        email: _email,
                        password: _password,
                      );
                      // Navigate to CoffeeMenuPage after successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CoffeeMenuPage()),
                      );
                    } catch (e) {
                      print(e);
                      // Show error to user if needed
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
