import 'package:boardinghouse_app/providers/auth_provider.dart';
import 'package:boardinghouse_app/screens/authu/begin_page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'register_page.dart';
import 'package:provider/provider.dart';
// import 'package:boardinghouse_app/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _controllerEmailPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool passwordVisible = true;

  final AuthProvider _authProvider = AuthProvider();

  void _handleLogin() async {
    if (_formkey.currentState!.validate()) {
      // _formKey.currentState!.save();

      try {
        // Call the login method from AuthProvider
        await _authProvider.login(
          _controllerEmailPhone.text,
          _controllerPassword.text,
        );

        // Check if the user is logged in
        if (_authProvider.authenticated) {
          // Navigate to the main screen upon successful login
          Navigator.of(context).pushReplacementNamed('main');
        }
      } catch (error) {
        // Handle login failure (e.g., show an error message)
        print("Login failed: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: IconButton(
              color: const Color.fromRGBO(0, 177, 237, 1),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BeginPage()));
              },
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Đăng nhập",
              style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _controllerEmailPhone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'nhập Email hoặc số điện thoại';
                        } else if (!isValidEmail(value) &&
                            !isValidPhoneNumber(value)) {
                          return ' Email hoặc SDT không hợp lệ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'Email hoặc số điện thoại',
                          labelText: 'Email hoặc số điện thoại',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.lightBlue,
                          ),
                          errorStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _controllerPassword,
                      obscureText: passwordVisible,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Enter first named'),
                        MinLengthValidator(6,
                            errorText: 'Minimum 3 charecter filled name'),
                      ]),
                      decoration: InputDecoration(
                          hintText: 'Mật khẩu',
                          labelText: 'Mật khẩu',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          errorStyle: const TextStyle(fontSize: 18.0),
                          // border: InputBorder.none,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _handleLogin();
                      // if (_formkey.currentState!.validate()) {
                      //   print('form submiitted');
                      //   Navigator.of(context).pushNamed('main');
                      // }
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(0, 177, 237, 1),
                        ),
                        child: const Center(
                          child: Text(
                            "Đăng nhập",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Stack(
                      children: [
                        const Divider(
                          thickness: 1,
                          color: Colors.black45,
                        ),
                        Positioned(
                            child: Center(
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.white,
                              child: const Text(
                                "hoặc",
                              )),
                        ))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('main');
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(0, 177, 237, 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              color: Colors.white,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Đăng nhập bằng Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black45,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          "Quên Mật Khẩu?",
                          style: TextStyle(fontSize: 14),
                        ),
                        InkWell(
                          child: const Text(
                            "  Lấy lại mật khẩu",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 177, 237, 1)),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          "Bạn chưa có tài khoản?",
                          style: TextStyle(fontSize: 14),
                        ),
                        InkWell(
                          child: const Text(
                            "  Đăng ký",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 177, 237, 1)),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  bool isValidEmail(String value) {
    // Hàm kiểm tra giá trị có đúng định dạng email không
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(value);
  }

  bool isValidPhoneNumber(String value) {
    // Hàm kiểm tra giá trị có đúng định dạng số điện thoại không
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    return phoneRegex.hasMatch(value);
  }
}
