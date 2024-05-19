// import 'package:flutter/material.dart';
// import 'package:cafe/login.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Register Page',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: RegisterPage(),
//     );
//   }
// }
//
// class RegisterPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         title: Text('Register'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//
//           children: [
//             // Name Field
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Name',
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             SizedBox(height: 50.0),
//
//             // Email Field
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             SizedBox(height: 50.0),
//
//             // Contact Number Field
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Contact Number',
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             SizedBox(height: 50.0),
//
//             // Password Field
//             TextFormField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             SizedBox(height: 50.0),
//
//
//             ElevatedButton(
//               onPressed: () {
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.black,
//                 onPrimary: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 15),
//               ),
//               child: Text(
//                 'Sign Up',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// iimport 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'login.dart'; // Import the LoginPage
//
// class RegisterPage extends StatefulWidget {
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _auth = FirebaseAuth.instance;
//
//   String _email = '';
//   String _password = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         title: Text('Register'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Logo
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('assets/logo.png'), // Replace 'assets/logo.png' with the path to your logo image
//             ),
//             SizedBox(height: 20),
//
//             // Email Field
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your email';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 _email = value!;
//               },
//             ),
//             SizedBox(height: 50.0),
//
//             // Password Field
//             TextFormField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your password';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 _password = value!;
//               },
//             ),
//             SizedBox(height: 50.0),
//
//             ElevatedButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
//                   try {
//                     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//                       email: _email,
//                       password: _password,
//                     );
//                     // Navigate to login page after registration
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                     );
//                   } catch (e) {
//                     print(e);
//                     // Show error to user if needed
//                   }
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.black,
//                 onPrimary: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 15),
//               ),
//               child: Text(
//                 'Sign Up',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart'; // Import the LoginPage

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
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
                    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );
                    // Navigate to login page after registration
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
                'Sign Up',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
