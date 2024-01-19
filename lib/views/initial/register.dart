import 'package:excuse_demo/components/cells/initial/initial_cells.dart';
import 'package:excuse_demo/service/user_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  Color _eyeColor = Colors.grey;
  int pageId = 0;

  //输入框控制器
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _repasswordController;

  @override
  void initState() {
    super.initState();

    //控制器初始化
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _repasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: kToolbarHeight),
            buildTitle(pageId),
            buildTitleLine(),
            const SizedBox(height: 60),
            // Center(
            //   child: buildAvatatField(context),
            // ),
            // const SizedBox(height: 30),
            buildNameTextField(context),
            const SizedBox(height: 30),
            buildPhoneTextField(context),
            const SizedBox(height: 30),
            buildPasswordTextField(context),
            const SizedBox(height: 30),
            buildRepasswordTextField(context),
            const SizedBox(height: 60),
            buildRegisterButton(),
            const SizedBox(height: 40),
            buildText(context, pageId),
          ],
        ),
      ),
    );
  }

  buildNameTextField(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      onSaved: (v) => _nameController.text = v!,
      decoration: const InputDecoration(labelText: '用户名'),
      validator: (v) {
        if (v!.isEmpty) {
          return "请输入用户名";
        }
        return null;
      },
    );
  }

  //手机号码文本框
  buildPhoneTextField(BuildContext context) {
    return TextFormField(
      controller: _phoneController,
      onSaved: (v) => _phoneController.text = v!,
      decoration: const InputDecoration(labelText: '手机号码'),
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

  //密码文本框
  buildPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isObscure,
      onSaved: (v) => _passwordController.text = v!,
      validator: (v) {
        if (v!.isEmpty) {
          return '请输入密码';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "密码",
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: _eyeColor,
          ),
          onPressed: () {
            setState(
              () {
                _isObscure = !_isObscure;
                _eyeColor = (_isObscure
                    ? Colors.grey
                    : Theme.of(context).iconTheme.color)!;
              },
            );
          },
        ),
      ),
    );
  }

  //重复密码文本框
  buildRepasswordTextField(BuildContext context) {
    return TextFormField(
      controller: _repasswordController,
      obscureText: _isObscure,
      onSaved: (v) => _repasswordController.text = v!,
      validator: (v) {
        if (v!.isEmpty) {
          return '请再次输入密码';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "确认密码",
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: _eyeColor,
          ),
          onPressed: () {
            setState(
              () {
                _isObscure = !_isObscure;
                _eyeColor = (_isObscure
                    ? Colors.grey
                    : Theme.of(context).iconTheme.color)!;
              },
            );
          },
        ),
      ),
    );
  }

  //注册按钮
  buildRegisterButton() {
    return InkWell(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            // 设置圆角
            shape: MaterialStateProperty.all(
              const StadiumBorder(
                side: BorderSide(style: BorderStyle.none),
              ),
            ),
          ),
          child: const Text(
            '注册',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          onPressed: () {
            String name = _nameController.text;
            String phone = _phoneController.text;
            String password = _passwordController.text;
            String repassword = _repasswordController.text;
            if (name.isEmpty ||
                phone.isEmpty ||
                password.isEmpty ||
                repassword.isEmpty) {
              return;
            }
            registerService(name, phone, password, repassword);
          },
        ),
      ),
    );
  }
}
