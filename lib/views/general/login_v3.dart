import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Background Color
      backgroundColor: Colors.grey[200],

      
      // Body
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 280,
                color: Colors.red,
              ),

              const SizedBox(height: 20),
              
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                
                child: Column(
                  children: [
                    
                    // Username 
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900
                            ),  
                          ),

                          const SizedBox(height: 5),

                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green.shade300, width: 3),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green.shade300, width: 3),
                                borderRadius: BorderRadius.circular(14),
                              ),

                              hoverColor: Colors.green.shade50,
                            ),
                            cursorColor: Colors.green,
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Password
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900
                            ),  
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green.shade300, width: 3),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green.shade300, width: 3),
                                    borderRadius: BorderRadius.circular(14),
                                  ),

                                  hoverColor: Colors.green.shade50,
                                ),
                                cursorColor: Colors.green,
                              ),

                              const SizedBox(width: 10),

                              // IconButton(
                              //   icon: const Icon(Icons.remove_red_eye),
                              //   color: Colors.green,
                              //   iconSize: 30,
                              //   onPressed: () {},
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Login As
                    Container(
                      // 
                    ),

                    // Remember Me
                    Container(
                      // 
                    ),

                    // Login Button
                    Container(
                      // 
                    ),

                    // Login With Google
                    // Container(
                    //   // 
                    // ),

                    // Reset Password
                    // Container(
                    //   // 
                    // ), 
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