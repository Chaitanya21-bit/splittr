import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'),
              fit: BoxFit.fitHeight
          ),),
        child : Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: 10,
                  left: 50,
                ),
                child: Text("Sign Up",
                  style: TextStyle(color: Colors.black,fontSize: 40),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3,
                      right: 30,
                      left: 30),
                  child: Column(
                    children: [

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          labelText: "Phone Number",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        obscureText: true ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Name",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        obscureText: true ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Alias",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        obscureText: true ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        obscureText: true ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Confirm Password",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      ElevatedButton(
                        onPressed: () => {},
                        child: Text("Sign Up"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xff1870B5)),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                      ),
                      Row(
                        children: [
                          Text("Already have an Account ? "),
                          TextButton(onPressed: () => {}, child: Text("Sign In"))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}

























