import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruitshop/modules/login/login_controller.dart';
import 'package:fruitshop/modules/widgets/buttons/button_primary.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      builder: (_controller) => Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/shop_logo.svg",
                    color: Colors.white,
                    height: 200.h,
                  ),
                  SizedBox(height: 32),
                  const Text(
                    "Ola, que bom te ver por aqui! :)",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 32),
                  Container(
                    width: 200.w,
                    child: ButtonPrimary(
                      buttonText: "Continuar",
                      callback: () {
                        _controller.handleLogin();
                      },
                      isLoading: _controller.isLoading,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
