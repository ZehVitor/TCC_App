import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_app/Components/CustomAlert.dart';
import 'package:tcc_app/DAOs/FuncionarioDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:tcc_app/Screens/AddUserScreen.dart';
import 'package:tcc_app/Screens/homeScreen.dart';
import 'package:tcc_app/UI/IconInput.dart';
import 'package:local_auth/local_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _usesFingerPrint = true;
  final loginControl = TextEditingController();
  final passControl  = TextEditingController();
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,

        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              widthFactor: 0.6,
              heightFactor: 0.6,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(200.0)),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: Container(
                  width: 400,
                  height: 400,
                ),
              ),
            ),

            Center(
              child: Container(
                width: 400,
                height: 400,
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Material(
                    //   elevation: 10.0,
                    //   borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    //   // child: Image.asset(
                    //   //     'images/suriIcon.png',
                    //   //     width: 100,
                    //   //     height: 100,
                    //   //   ),
                    //   child: Image.network(
                    //     'https://beira.pt/coolkids/wp-content/uploads/sites/7/2014/08/shutterstock_93148597d.jpg',
                    //     width: 100,
                    //     height: 100,
                        
                    //   ),
                    // ),
                    // CircleAvatar(
                    //     radius: 60.0,
                    //     backgroundColor: Colors.transparent,
                    //     child: Image.network(
                    //       'https://beira.pt/coolkids/wp-content/uploads/sites/7/2014/08/shutterstock_93148597d.jpg',
                    //     )
                    // ),
                    Text("Registro de informações em\nApp de Implantes Dentários", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20,),
                    IconInput(
                      Icon(Icons.person, color: Colors.blue),
                      'CRO',
                      false,
                      loginControl
                    ),
                    IconInput(
                      Icon(Icons.lock, color: Colors.blue),
                      'Password',
                      true,
                      passControl
                    ),

                    Container(
                      width: 150.0,
                      // Login button
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(children: 
                            <Widget>[
                              RaisedButton(
                                onPressed: () async {   
                                    FuncionarioDAO user = FuncionarioDAO(10, 'Gilvani', loginControl.text, passControl.text, 'email@teste.com');
                                    if (_usesFingerPrint){
                                      _checkBiometricSensor();
                                      CustomAlert(
                                        context: context,
                                        title: 'Biometria',
                                        msg: 'Autentique-se com a digital',
                                      );
                                    }
                                    model.signIn(
                                      user: user.toMap(),

                                      onSuccess: (){
                                        Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) => HomeScreen())
                                        );
                                      },

                                      onFail: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context){
                                            return AlertDialog(
                                                title: Text('Autenticação'),
                                                content: Text('Usuário e/ou senha não encontrado.'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Fechar'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                            );
                                          }
                                        );
                                      }
                                    );
                                },
                                color: Colors.amberAccent,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20.0
                                  ),
                                ),
                              ),
                              
                              RaisedButton(
                                onPressed: () async {   
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => AddUserScreen())
                                  );
                                },
                                color: Colors.amberAccent,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: Text(
                                  'Cadastre-se',
                                  style: TextStyle(
                                    fontSize: 20.0
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkBiometricSensor() async {
    try {
      var authenticate = await _localAuth.authenticateWithBiometrics(
          localizedReason: 'Por favor autentique-se para continuar');
      setState(() {
        if (authenticate) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                  title: Text('Biometria'),
                  content: Text('Digital não reconhecida.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Tentar novamente'),
                      onPressed: () {
                        setState(() {
                          _usesFingerPrint = true;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        setState(() {
                          _usesFingerPrint = false;
                        });
                        Navigator.of(context).pop();
                      },
                    )
                  ],
              );
            }
          );
        }
      });
    }
    on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
                title: Text('Biometria'),
                content: Text('Sensor biométrico não encontrado. Por favor, utilize o login e senha.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Fechar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
            );
          }
        );
        setState(() {
          _usesFingerPrint = false;
        });
      }
    }
  }
}
