import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitagoras_app/users/authentication/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context,cons){
          return ConstrainedBox( //Empezamos el diseño de Login
            constraints: BoxConstraints(
              minHeight: cons.maxHeight, //Configuramos altura minima de la pantalla
            ),
            child: SingleChildScrollView( //Damos posibilidad para hacer scroll
              child: Column( //Creamos columna
                children: [
                  //Login Screen Header
                  SizedBox( //Creamos contenedor
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset('assets/images/login_header.png'),

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
                            offset: Offset(0,-3)
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,30,30,8),
                        child: Column(
                          children: [

                            //Furmulario-LOGIN
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  //user email
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) => val == "" ? "Por favor escribir e-mail válido" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      hintText: "email",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 18,),
                                  //user password
                                  Obx(
                                      ()=>TextFormField(
                                        controller: passwordController,
                                        obscureText: isObsecure.value,
                                        validator: (val) => val == "" ? "Por favor escribir contraseña válida" : null,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.vpn_key_sharp,
                                            color: Colors.black,
                                          ),
                                          suffixIcon: Obx(
                                                  ()=> GestureDetector(
                                                onTap:(){
                                                  isObsecure.value =! isObsecure.value;

                                                },
                                                child: Icon(
                                                  isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                                  color: Colors.black,
                                                ),
                                              )
                                          ),
                                          hintText: "passsword",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                      ),
                                  ),

                                  const SizedBox(height: 18,),

                                  //Login Button
                                  Material(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 30,
                                        ),
                                        child: Text(
                                            "Login",
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

                            SizedBox(height:16),

                            //Botón de registro
                            Row(
                              children: [
                                Text("No tienes cuenta?"),
                                TextButton(
                                  onPressed: (){
                                      Get.to(SignupScreen());
                                  },
                                  child: const Text(
                                    "Registro aquí",
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                )
                              ],
                            ),

                            Text(
                              "Or",
                              style: TextStyle(
                                fontSize: 16
                              ),
                            ),

                            //admin
                            Row(
                              children: [
                                Text("Eres admin?"),
                                TextButton(
                                  onPressed: (){

                                  },
                                  child: const Text(
                                    "Presiona aquí",
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
