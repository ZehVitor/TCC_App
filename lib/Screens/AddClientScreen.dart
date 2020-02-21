import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/ClientDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AddClientScreen extends StatefulWidget {

  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final cpfControl  = TextEditingController();

  final nomeControl  = TextEditingController();

  final foneControl  = TextEditingController();

  final enderecoControl  = TextEditingController();

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
          title: Text('Novo Paciente'),
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
                  hintText: 'CPF'
                ),
                keyboardType: TextInputType.number,
                validator: (text){
                  if (text.isEmpty) //|| !text.contains(".") || !text.contains("-") || text.length != 14
                    return "CPF inválido, informe o CPF com a pontuação correta";
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
                controller: foneControl,
                decoration: InputDecoration(
                  hintText: 'Fone'
                ),
                keyboardType: TextInputType.phone,
                validator: (text){
                  if (text.isEmpty)
                    return "Fone inválido";
                },
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: enderecoControl,
                decoration: InputDecoration(
                  hintText: 'Endereco'
                ),
                validator: (text){
                  if (text.isEmpty)
                    return "Endereco inválido";
                },
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: cidadeControl,
                decoration: InputDecoration(
                  hintText: 'Cidade'
                ),
                validator: (text){
                  if (text.isEmpty)
                    return "Cidade inválido";
                },
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: profissaoControl,
                decoration: InputDecoration(
                  hintText: 'Profissao'
                ),
                validator: (text){
                  if (text.isEmpty)
                    return "Profissao inválido";
                },
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: estCivilControl,
                decoration: InputDecoration(
                  hintText: 'Estado Civil'
                ),
                validator: (text){
                  if (text.isEmpty)
                    return "Estado Civil inválido";
                },
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: nascimentoControl,
                decoration: InputDecoration(
                  hintText: 'Nascimento'
                ),
                validator: (text){
                  if (text.isEmpty)
                    return "Nascimento inválido";
                },
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
                      ClientDAO paciente = ClientDAO(1, nomeControl.text, foneControl.text, emailControl.text);
                      paciente.cpf = cpfControl.text;
                      paciente.endereco = enderecoControl.text;
                      paciente.cidade = cidadeControl.text;
                      paciente.profissao = profissaoControl.text;
                      paciente.nascimento = nascimentoControl.text;
                      paciente.estadoCivil = estCivilControl.text;
                      paciente.dataCadastro = DateFormat('dd-MM-yyyy').format(DateTime.now());
                      
                      // // ProductDAO implante = ProductDAO(1, 'Implante Dentário');
                      // // implante.images.add('http://oralunic.com.br/wp-content/uploads/2019/07/implantes-interna.png');
                      // // implante.tipoProduto = 'Implante';

                      // paciente.produtos.add(implante);
                      model.pacientes.add(paciente);
                      
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Adicionado com sucesso!"),
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