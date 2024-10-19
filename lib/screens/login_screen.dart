import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'package:flutter_signin_button/flutter_signin_button.dart'; // For social sign-in buttons

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser(String email, String password) async {
    try {
      // Send POST request to login API
      final response = await http.post(
        Uri.parse('https://dev-api.aladia.io/v2/auth/login'),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // Decode the JSON response if the login is successful
        final data = json.decode(response.body);
        print('Login successful: $data');
      } else {
        // Log error if the response status code is not 200
        print('Login failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background as per the design
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

                      Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Aladia logo at the left
                Image.asset(
                  'assets/icon/home.png', 
                  height: 100,
                ),
                const SizedBox(width: 20),
                // Welcome text and description on the right
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Aladia,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Create or access your account from here',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
            // Aladia logo at the top
            // Image.asset(
            //   'assets/icon/home.png', // Replace with your logo path
            //   height: 100,
            // ),
            // const SizedBox(height: 20),
            // Welcome text and description
            // const Text(
            //   'Welcome to Aladia,',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 10),
            // const Text(
            //   'Create or access your account from here',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 16,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 30),
            // Enter your email
            const Text(
              'Enter your email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            // Email input field
            TextField(
              controller: _emailController, // Controller for email input
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email, color: Colors.white),
                labelText: 'E-mail',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Password input field
            const Text(
              'Enter your password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController, // Controller for password input
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            // Enter button
            ElevatedButton(
              onPressed: () {
                // Get email and password from controllers and call the login function
                final email = _emailController.text;
                final password = _passwordController.text;

                if (email.isNotEmpty && password.isNotEmpty) {
                  loginUser(email, password);
                } else {
                  print('Please fill in both fields');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Enter',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // "Or" divider
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey.withOpacity(0.5),
                    thickness: 1,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Or',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey.withOpacity(0.5),
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Sign in with Google, Facebook, and Apple buttons
            SignInButton(
              Buttons.Google,
              onPressed: () {
                // Handle Google sign-in
              },
            ),
            const SizedBox(height: 10),
            SignInButton(
              Buttons.Facebook,
              onPressed: () {
                // Handle Facebook sign-in
              },
            ),
            const SizedBox(height: 10),
            SignInButton(
              Buttons.Apple,
              onPressed: () {
                // Handle Apple sign-in
              },
            ),
            const Spacer(),
            // Terms & Conditions link at the bottom
            const Text(
              'Terms & conditions',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert'; // For JSON decoding

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> loginUser(String email, String password) async {
//     try {
//       // Send POST request to login API
//       final response = await http.post(
//         Uri.parse('https://dev-api.aladia.io/v2/auth/login'),
//         body: {'email': email, 'password': password},
//       );

//       if (response.statusCode == 200) {
//         // Decode the JSON response if the login is successful
//         final data = json.decode(response.body);
//         print('Login successful: $data');
//       } else {
//         // Log error if the response status code is not 200
//         print('Login failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Error occurred: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Login',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _emailController, // Controller for email input
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _passwordController, // Controller for password input
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Get email and password from controllers and call the login function
//                 final email = _emailController.text;
//                 final password = _passwordController.text;

//                 if (email.isNotEmpty && password.isNotEmpty) {
//                   loginUser(email, password);
//                 } else {
//                   print('Please fill in both fields');
//                 }
//               },
//               child: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
