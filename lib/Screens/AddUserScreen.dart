import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/ClientDAO.dart';
import 'package:tcc_app/DAOs/FuncionarioDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AddUserScreen extends StatefulWidget {

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final cpfControl  = TextEditingController();

  final nomeControl  = TextEditingController();

  final loginControl  = TextEditingController();

  final passControl  = TextEditingController();

  final cidadeControl  = TextEditingController();

  final profissaoControl  = TextEditingController();

  final estCivilControl  = TextEditingController();

  final nascimentoControl  = TextEditingController();

  final emailControl  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Novo usuário'),
          centerTitle: true,
        ),
        
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                controller: cpfControl,
                decoration: InputDecoration(
                  hintText: 'CRO'
                ),
                keyboardType: TextInputType.number,
                validator: (text){
                  if (text.isEmpty)
                    return "CRO inválido.";
                },
              ),

              SizedBox(height: 16.0,),
              TextFormField(
                controller: nomeControl,
                decoration: InputDecoration(
                  hintText: 'Nome'
                ),
                validator: (text){
                  if (text.isEmpty)
                    return "Nome inválido";
                },
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: loginControl,
                decoration: InputDecoration(
                  hintText: 'Login'
                ),
                validator: (text){
                  if (text.isEmpty)
                    return "Login inválido";
                },
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: passControl,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: emailControl,
                decoration: InputDecoration(
                  hintText: 'email'
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (text){
                  if (text.isEmpty || !text.contains("@"))
                    return "email inválido";
                },
              ),
              SizedBox(height: 16.0,),
              
              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  child: Text('Salvar', style: TextStyle(fontSize: 18),),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      FuncionarioDAO user = FuncionarioDAO(10, nomeControl.text, loginControl.text, passControl.text, emailControl.text);
                      
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Cadastro realizado com sucesso!"),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: Duration(seconds: 1),
                          onVisible: (){
                            sleep(Duration(seconds: 1));
                            Navigator.of(context).pop();
                                    
                          },
                        )
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        )
      );
      },
    );
  }
}