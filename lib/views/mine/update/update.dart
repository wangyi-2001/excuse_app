import 'package:flutter/material.dart';

class InfoUpdatePage extends StatefulWidget {
  const InfoUpdatePage({super.key});

  @override
  State<InfoUpdatePage> createState() => _InfoUpdatePageState();
}

class _InfoUpdatePageState extends State<InfoUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('更新个人信息'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(
            //   height: 10,
            // ),
            buildNameField(),
            SizedBox(
              height: 10,
            ),
            buildPhoneField(),
            SizedBox(
              height: 10,
            ),
            buildEmailField(),
            SizedBox(
              height: 10,
            ),
            buildPasswordField(),
          ],
        ),
      ),
    );
  }

  buildNameField(){
    return Scaffold(

    );
  }

  buildPhoneField(){
    return Scaffold(

    );
  }

  buildEmailField(){
    return Scaffold(

    );
  }

  buildPasswordField(){
    return Scaffold(

    );
  }
}
