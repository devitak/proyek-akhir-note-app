  import 'package:flutter/material.dart';
  import 'package:crypto/crypto.dart';
  import 'package:note_bucket/pages/home_page.dart';
  import 'package:note_bucket/utils/user_manager.dart';
  import 'dart:convert';

  class LoginPage extends StatelessWidget {
    const LoginPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: const MyStatefulWidget(),
        ),
      );
    }
  }

  class MyStatefulWidget extends StatefulWidget {
    const MyStatefulWidget({Key? key}) : super(key: key);

    @override
    State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
  }

  class _MyStatefulWidgetState extends State<MyStatefulWidget> {
    String username = "";
    String password = "";

    bool isLogin = false;
    bool isPasswordVisible = true;

    late TextEditingController usernameController;
    late TextEditingController passwordController;

    @override
    void initState() {
      super.initState();
      usernameController = TextEditingController();
      passwordController = TextEditingController();
    }

    @override
    void dispose() {
      usernameController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    String hashPassword(String password) {
      var bytes = utf8.encode(password); // Encode password to UTF-8
      var digest = sha256.convert(bytes); // Perform SHA-256 encryption
      return digest.toString(); // Return encrypted password
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffffebee),
                Color(0xffffcdd2),
                Color(0xffffa5a5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/login.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please Login First !',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding:
                        EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        labelText: 'Username',
                        hintText: 'Enter username',
                        labelStyle: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding:
                        EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        labelText: 'Password',
                        hintText: 'Enter password',
                        labelStyle: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String message = "";
                      username = usernameController.text;
                      String enteredPassword = hashPassword(passwordController.text.trim()); // Enkripsi password yang dimasukkan pengguna

                      print('Entered Username: $username');
                      print('Entered Password: $enteredPassword');

                      print('UserManager.users: ${UserManager.users}');

                      if (UserManager.users.containsKey(username)) {
                        print('Stored Password: ${UserManager.users[username]}');
                      } else {
                        print('Username not found');
                      }

                      if (UserManager.users.containsKey(username) &&
                          UserManager.users[username] == enteredPassword) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeView(),
                          ),
                        );
                        setState(() {
                          message = "Login Successful";
                          isLogin = true;
                        });
                      } else {
                        message = "Login Failed";
                        isLogin = false;
                      }
                      var snackBar = SnackBar(
                        content: Text(message),
                        backgroundColor: isLogin ? Colors.green : Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: Size(150, 50),
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
        ),
      );
    }
  }
