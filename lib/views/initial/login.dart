import 'package:excuse_demo/common/page_jump_animation.dart';
import 'package:excuse_demo/components/cells/initial/initial_cells.dart';
import 'package:excuse_demo/service/user_service.dart';
import 'package:excuse_demo/views/initial/change_pwd.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  Color _eyeColor = Colors.grey;
  int pageId = 1;

  //输入框控制器
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  //用户协议手势
  late TapGestureRecognizer _registProtocolRecognizer;
  late TapGestureRecognizer _privacyProtocolRecognizer;

  //抖动动画次数
  int inputAnimationNumber = 0;

  //是否勾选用户协议
  bool isProtocolError = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //控制器初始化
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();

    //手势初始化
    _registProtocolRecognizer = TapGestureRecognizer();
    _privacyProtocolRecognizer = TapGestureRecognizer();
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
            buildPhoneTextField(context),
            const SizedBox(height: 30),
            buildPasswordTextField(context),
            buildForgetPasswordText(context),
            const SizedBox(height: 60),
            buildLoginButton(),
            const SizedBox(height: 40),
            buildText(context, pageId),
          ],
        ),
      ),
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
        if (!phoneReg.hasMatch(v!) || v == "") {
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
              setState(() {
                _isObscure = !_isObscure;
                _eyeColor = (_isObscure
                    ? Colors.grey
                    : Theme.of(context).iconTheme.color)!;
              });
            },
          )),
    );
  }

  //右下方忘记密码文字，点击跳转到忘记密码页面
  buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                CustomRouteSlideRight(const ChangePwdPage()),
                (Route route) => false);
          },
          child: const Text("忘记密码？",
              style: TextStyle(fontSize: 14, color: Colors.grey)),
        ),
      ),
    );
  }

  //登录按钮，验证信息和数据库是否匹配
  buildLoginButton() {
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
            '登录',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          onPressed: () {
            // BotToast.showLoading();
            String phone = _phoneController.text;
            String password = _passwordController.text;
            if (phone.isEmpty || password.isEmpty) {
              return;
            }
            loginService(phone, password);
            print(loginService(phone, password));
          },
        ),
      ),
    );
  }
}
