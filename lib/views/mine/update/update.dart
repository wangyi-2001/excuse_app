import 'package:flutter/material.dart';

class InfoUpdatePage extends StatefulWidget {
  const InfoUpdatePage({super.key});

  @override
  State<InfoUpdatePage> createState() => _InfoUpdatePageState();
}

class _InfoUpdatePageState extends State<InfoUpdatePage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('更新个人信息'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: 30,
            ),
            buildNameField(),
            SizedBox(
              height: 30,
            ),
            buildPhoneField(),
            SizedBox(
              height: 30,
            ),
            buildEmailField(),
            SizedBox(height: 50,),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextFormField(
      controller: _nameController,
      onSaved: (v) => _nameController.text = v!,
      decoration: const InputDecoration(
          labelText: '用户名', border: OutlineInputBorder(), hintText: '请输入用户名'),
      validator: (v) {
        if (v!.isEmpty) {
          return "请输入用户名";
        }
        return null;
      },
    );
  }

  buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      onSaved: (v) => _phoneController.text = v!,
      decoration: const InputDecoration(
          labelText: '手机号码',
          border: OutlineInputBorder(),
          helperText: '登录手机号同步更改',
          hintText: '请输入13位中国大陆手机号码'),
      validator: (v) {
        var phoneReg = RegExp(
            r"^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$");
        if (!phoneReg.hasMatch(v!) || v.isEmpty) {
          return '请输入正确手机号';
        }
        return null;
      },
    );
  }

  buildEmailField() {
    return TextFormField(
      controller: _emailController,
      onSaved: (v) => _emailController.text = v!,
      decoration:
          const InputDecoration(labelText: '邮箱', border: OutlineInputBorder(),hintText: '请输入邮箱地址'),
      validator: (v) {
        if (v!.isEmpty) {
          return "请输入邮箱";
        }
        return null;
      },
    );
  }

  buildSubmitButton(){
    return InkWell(
      child: SizedBox(
        height: 60,
        // width: 160,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent[100]),
          ),
          onPressed: () {  },
          child: Text(
            '提交',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
