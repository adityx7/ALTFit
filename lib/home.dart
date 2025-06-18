
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class HomePage extends StatelessWidget {

  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Padding(
        padding : EdgeInsets.all(50.0),
        child: Center(
          child: Text("My Home Page", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
        )
      ),
    );
  }
}
