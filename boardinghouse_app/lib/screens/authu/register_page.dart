import 'package:boardinghouse_app/screens/authu/begin_page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool passwordVisible = true;

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
              "Đăng ký",
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
                      controller: _controllerUsername,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Enter first named'),
                        MinLengthValidator(3,
                            errorText: 'Minimum 3 charecter filled name'),
                      ]),
                      decoration: const InputDecoration(
                          hintText: 'Tên đăng nhập',
                          labelText: 'Tên đăng nhập',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          errorStyle: TextStyle(fontSize: 18.0),
                          // border: InputBorder.none,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      // focusNode: _focusNodeEmail,
                      controller: _controllerEmail,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Enter email address'),
                        EmailValidator(
                            errorText: 'Please correct email filled'),
                      ]),
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
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
                      controller: _controllerPhone,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Enter mobile number'),
                        PatternValidator(r'^[0-9]{10}$',
                            errorText: 'enter vaid mobile number'),
                      ]),
                      decoration: const InputDecoration(
                          hintText: 'Số điện thoại',
                          labelText: 'Số điện thoại',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
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
                      if (_formkey.currentState!.validate()) {
                        print('form submiitted');
                        Navigator.of(context).pushNamed('login');
                      }
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(0, 177, 237, 1),
                        ),
                        child: const Center(
                          child: Text(
                            "Đăng ký",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: const Text(
                        "Khi đăng ký, bạn đã đồng ý với các Điều khoản và chính sách của SEBOA",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
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
                          "Bạn đã có tài khoản?",
                          style: TextStyle(fontSize: 14),
                        ),
                        InkWell(
                          child: const Text(
                            "  Đăng nhập",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 177, 237, 1)),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          "Tại sao bạn nên đăng ký tài khoản?",
                          style: TextStyle(fontSize: 14),
                        ),
                        InkWell(
                          child: const Text(
                            "  Quy định",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 177, 237, 1)),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
