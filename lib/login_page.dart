import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fomo_app/home_page.dart';
import 'package:fomo_app/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FOMO Tracker - Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 20,
                child: Image(
                  image: NetworkImage("https://img.freepik.com/free-vector/flat-design-mc-logo-design_23-2149482035.jpg?w=2000"),
                  fit: BoxFit.cover,
                  width: 500,
                ),
              ),
              Expanded(
                flex: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 20),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 10),
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text, password: passwordController.text)
                              .then((value) {
                                print("Successfully logged user ${emailController.text} in!" );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HomePage())
                                );
                          }).catchError((error) {
                            print("Failed to log ${emailController.text} in!");
                            print(error);
                          });
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  side: BorderSide(color: Colors.blue),
                                )
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                          "OR",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupPage())
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  side: BorderSide(color: Colors.blue),
                                )
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage())
                          );
                        },
                        child: Text(
                          'Test Home',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  side: BorderSide(color: Colors.blue),
                                )
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
