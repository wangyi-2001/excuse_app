import 'package:bot_toast/bot_toast.dart';
import 'package:excuse_demo/components/cells/initial/initial_cells.dart';
import 'package:excuse_demo/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePwdPage extends StatefulWidget {
  const ChangePwdPage({super.key});

  @override
  State<ChangePwdPage> createState() => _ChangePwdPageState();
}

class _ChangePwdPageState extends State<ChangePwdPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  //密码是否可见
  bool _isObscure = true;

  //眼睛图标初始颜色
  Color _eyeColor = Colors.grey;
  int pageId = 2;

  //输入框控制器
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    //初始化控制器
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
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
            const SizedBox(
              height: 60,
            ),
            buildTitle(pageId),
            buildTitleLine(),
            const SizedBox(height: 60),
            buildPhoneTextField(context),
            const SizedBox(height: 30),
            buildPasswordTextField(context),
            const SizedBox(height: 60),
            buildForgetPwdButton(),
            const SizedBox(height: 40),
            buildText(context, pageId),
          ],
        ),
      ),
    );
  }

  //输入手机号文本框
  buildPhoneTextField(BuildContext context) {
    return TextFormField(
      controller: _phoneController,
      onSaved: (v) => _phoneController.text = v!,
      decoration: const InputDecoration(labelText: '手机号码'),
      validator: (v) {
        //通过正则表达式验证手机号码是否合规
        var phoneReg = RegExp(
            r"^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$");
        //验证手机号码是否为空
        if (!phoneReg.hasMatch(v!) || v.isEmpty) {
          return '请输入正确手机号';
        }
        return null;
      },
    );
  }

  //输入密码文本框
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
          labelText: "新密码",
          //后面控制密码是否可见的眼睛，点击改变颜色并改变密码可见状态
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

  //修改密码按钮
  buildForgetPwdButton() {
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
            '更改密码',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          onPressed: () {
            BotToast.showLoading();
            String phone = _phoneController.text;
            String password = _passwordController.text;
            if (phone.isEmpty || password.isEmpty) {
              return;
            }
            //传递数据
            Future.delayed(Duration(milliseconds: 100),(){
              changePwdService(phone, password);
              BotToast.closeAllLoading();
            });
          },
        ),
      ),
    );
  }
}
