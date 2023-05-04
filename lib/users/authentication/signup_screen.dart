import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pitagoras_app/users/authentication/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:pitagoras_app/users/model/user.dart';

import '../../api_connection/api_connection.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();

  var idController = TextEditingController();
  var nameController = TextEditingController();
  var lastNameController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  validateUserID() async {
    try {
      print(idController.text);
      var res = await http.post(
        Uri.parse(API.validateID),
        body: {
          'user_id': idController.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        //conexion exitosa con API
        print(res.body);
        var resBody = res.body;
        var resBodyID = jsonDecode(resBody);
        print(resBodyID);
        if (resBodyID['idFound'] == true) {
          Fluttertoast.showToast(
              msg: "Ya existe cuenta con el número de Cédula ingresado.");
        } else {
          print("Registrar usuario.");
          //Registrar nuevo usuario a DB
          registerAndSaveUserRecord();
        }
      } else {
        print("Conexión fallida");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registerAndSaveUserRecord() async {
    User userModel = User(
      idController.text.trim(),
      nameController.text.trim(),
      lastNameController.text.trim(),
      passwordController.text.trim(),
    );
    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );
      print(res.body);
      if (res.statusCode == 200) {
        var resBody = res.body;
        var resBodySignUp = jsonDecode(resBody);
        if (resBodySignUp['success'] == true) {
          Fluttertoast.showToast(msg: "Usuario registrado exitosamente.");
        } else {
          Fluttertoast.showToast(msg: "Error al registrar usuario.");
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            //Empezamos el diseño de Signup
            constraints: BoxConstraints(
              minHeight:
                  cons.maxHeight, //Configuramos altura minima de la pantalla
            ),
            child: SingleChildScrollView(
              //Damos posibilidad para hacer scroll
              child: Column(
                //Creamos columna
                children: [
                  //Signup Screen Header
                  SizedBox(
                    //Creamos contenedor
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset('assets/images/register.png'),
                  ),
                  //Login Screen Sign-in Form
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.limeAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, -3))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column(
                          children: [
                            //Furmulario-LOGIN
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  //user id
                                  TextFormField(
                                    controller: idController,
                                    validator: (val) => val == ""
                                        ? "Por favor escribir DNI válido"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person_2,
                                        color: Colors.black,
                                      ),
                                      hintText: "cédula",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),
                                  //user name
                                  TextFormField(
                                    controller: nameController,
                                    validator: (val) => val == ""
                                        ? "Por favor escribir nombre válido"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      hintText: "nombre",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),

                                  //user last name
                                  TextFormField(
                                    controller: lastNameController,
                                    validator: (val) => val == ""
                                        ? "Por favor escribir apellido válido"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      hintText: "apellido",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),
                                  //user password
                                  Obx(
                                    () => TextFormField(
                                      controller: passwordController,
                                      obscureText: isObsecure.value,
                                      validator: (val) => val == ""
                                          ? "Por favor escribir contraseña válida"
                                          : null,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.vpn_key_sharp,
                                          color: Colors.black,
                                        ),
                                        suffixIcon: Obx(() => GestureDetector(
                                              onTap: () {
                                                isObsecure.value =
                                                    !isObsecure.value;
                                              },
                                              child: Icon(
                                                isObsecure.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.black,
                                              ),
                                            )),
                                        hintText: "passsword",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            )),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            )),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),

                                  //SignUp Button
                                  Material(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          //validate the id
                                          validateUserID();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 30,
                                        ),
                                        child: Text(
                                          "Registrarme",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16),

                            //Botón de Inicio de sesion
                            Row(
                              children: [
                                Text("Ya tengo una cuenta"),
                                TextButton(
                                  onPressed: () {
                                    Get.to(LoginScreen());
                                  },
                                  child: const Text(
                                    "Iniciar sesión",
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
