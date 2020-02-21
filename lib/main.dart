import 'package:flutter/material.dart';
import 'package:tcc_app/Models/OrderModel.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:tcc_app/Screens/LoginScreen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<OrderModel>(
            model: OrderModel(model),
            child: MaterialApp(
              title: 'Força de Vendas',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Color.fromARGB(255, 4, 125, 141)
              ),
              debugShowCheckedModeBanner: false,
              home: LoginScreen(),
              routes: <String, WidgetBuilder>{
                '/Login': (BuildContext context) => LoginScreen(),
              }
            ),
          );
        },
      )
    );
  }
}

