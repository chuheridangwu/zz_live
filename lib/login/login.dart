import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LoginView extends StatelessWidget {

  final _userNameController = TextEditingController();
  final _psdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _userNameController,
                  decoration: InputDecoration(
                    icon:Icon(Icons.lock),
                    border:InputBorder.none,
                    ),
                ),
                TextField(
                  controller: _psdController,
                  decoration: InputDecoration(icon:Icon(Icons.lock)),
                ),
                SizedBox(height: 8),
                OutlinedButton(
                  onPressed: (){},
                   child: Text("登录"),
                   
                   ),
                SizedBox(height: 8),
                OutlinedButton(onPressed: (){}, child: Text("注册")),
              ],
            ),
          ),
    );
  }
}