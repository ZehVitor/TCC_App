import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/ProductDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AddProductScreen extends StatefulWidget {

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  List _tipos =
  ["Implante", "Prótese"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _tipo;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _tipo = _dropDownMenuItems[0].value;
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final descricaoControl  = TextEditingController();
  final classControl  = TextEditingController();
  final precoControl  = TextEditingController();
  final imagemControl  = TextEditingController();
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
          title: Text('Novo Produto'),
          centerTitle: true,
        ),
        
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                controller: descricaoControl,
                decoration: InputDecoration(
                  hintText: 'Descrição'
                ),
                validator: (text){
                  if (text.isEmpty)
                    return "Descrição inválida";
                },
              ),

              SizedBox(height: 16.0,),
              // TextFormField(
              //   controller: classControl,
              //   decoration: InputDecoration(
              //     hintText: 'Classificação (Prótese, Implante)'
              //   ),
              //   validator: (text){
              //     if (text.isEmpty)
              //       return "Classificação inválida";
              //   },
              // ),
              DropdownButton(
                value: _tipo,
                items: _dropDownMenuItems,
                onChanged: (t){
                  setState(() {
                    _tipo = t;
                  });
                },
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: precoControl,
                decoration: InputDecoration(
                  hintText: 'Preço'
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0,),

              TextFormField(
                controller: imagemControl,
                decoration: InputDecoration(
                  hintText: 'Imagem'
                ),
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
                      ProductDAO produto = ProductDAO(1, descricaoControl.text);
                      produto.tipoProduto = _tipo;
                      produto.precoAtual = precoControl.text.isEmpty ? 0 : double.parse(precoControl.text.replaceAll(',', '.'));
                      
                      String img = 'https://www.uergs.edu.br/themes/modelo-noticias/images/outros/GD_imgSemImagem.png?classificacao=34752';
                      produto.images.add(imagemControl.text.isEmpty ? img : imagemControl.text);

                      if (produto.tipoProduto == "Prótese")
                        model.proteses.add(produto);
                      else
                        model.implantes.add(produto);
                      
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Adicionado com sucesso!"),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: Duration(seconds: 1),
                          onVisible: (){
                            sleep(Duration(seconds: 1));
                            Navigator.of(context).pop();
                          }
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

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String tp in _tipos) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: tp,
          child: new Text(tp)
      ));
    }

    return items;
  }
}