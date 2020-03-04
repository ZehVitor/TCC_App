import 'dart:io';
import 'package:intl/intl.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/ClientDAO.dart';
import 'package:tcc_app/DAOs/ProductDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductScreen extends StatefulWidget {

  final ProductDAO product;
  final bool editable;

  ProductScreen(this.product, this.editable);

  @override
  _ProductScreenState createState() => _ProductScreenState(product, editable);
}

class _ProductScreenState extends State<ProductScreen> {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ProductDAO product;
  final bool editable;
  
  String parafuso;

  String tipo;
  String conector;
  String plataforma;
  String tpPlataforma;
  String fabricante;
  String regiao;
  String torque;
  String ancoragem;
  String oclusao;
  String enxerto;
  String radioAltura;
  String caracteristica;
  String cobertura;
  String carga;
  String superficie;

  final tipoOutControl  = TextEditingController();
  final conectorOutControl  = TextEditingController();
  final plataformaOutControl  = TextEditingController();
  final tpPlataformaOutControl  = TextEditingController();
  final fabricanteOutControl  = TextEditingController();
  final regiaoOutControl  = TextEditingController();
  final torqueOutControl  = TextEditingController();
  final ancoragemOutControl  = TextEditingController();
  final oclusaoOutControl  = TextEditingController();
  final enxertoOutControl  = TextEditingController();
  
  final caracteristicaOutControl  = TextEditingController();
  final coberturaOutControl  = TextEditingController();
  final cargaOutControl  = TextEditingController();
  final superficieOutControl  = TextEditingController();
  final parafusoOutControl  = TextEditingController();

  _ProductScreenState(this.product, this.editable);

  @override
  void initState() {
    super.initState();
    if (UserModel.of(context).pacienteAtual == null)
      UserModel.of(context).pacienteAtual = ClientDAO(1, 'Não Cadastrado', '123456', 'naodefinido@naodefinido.com');
    
    ClientDAO paciente = UserModel.of(context).pacienteAtual;
    tipo = paciente.tipo;
    conector = paciente.conector;
    plataforma = paciente.plataforma;
    tpPlataforma = paciente.tpPlataforma;
    fabricante = paciente.fabricante;
    regiao = paciente.regiao;
    torque = paciente.torque;
    ancoragem = paciente.ancoragem;
    oclusao = paciente.oclusao;
    enxerto = paciente.enxerto;
    setState(() {
      radioAltura = paciente.altura;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return product.tipoProduto.toUpperCase() == 'PRÓTESE' ? retProtese(context) : retImplante(context);
  }

  Widget retImplante(BuildContext context){
    final primaryColor = editable ? Theme.of(context).primaryColor : Colors.green;
    return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(product.descricao),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.9,
                child: Carousel(
                  images: product.images.map((url){
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 4.0,
                  dotSpacing: 15,
                  dotBgColor: Colors.transparent,
                  dotColor: primaryColor,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Tipo', //vai ser tipo do implante
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.plataformas.map(
                          (t){
                            return GestureDetector(
                                onTap: (){
                                  setState((){
                                    plataforma = t;
                                    UserModel.of(context).pacienteAtual.plataforma = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: plataforma == t ? Theme.of(context).primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: plataforma == t ? Theme.of(context).primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text(
                      'Fabricante:', //vai ser tipo do implante
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.fabricantes.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    fabricante = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: fabricanteOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: fabricante == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: fabricante == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text(
                      'Plataforma:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.tpPlataformas.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    tpPlataforma = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: tpPlataformaOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: tpPlataforma == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: tpPlataforma == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text(
                      'Superficie:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.superficie.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    superficie = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: superficieOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: superficie == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: superficie == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text(
                      'Característica:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.caracteristicas.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    caracteristica = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: caracteristicaOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: caracteristica == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: caracteristica == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text(
                      'Região Implantada:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.dentes.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    regiao = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: regiaoOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: regiao == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: regiao == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.dentes2.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    regiao = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: regiaoOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: regiao == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: regiao == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),
                    
                    Text(
                      'Torque:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.torques.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    torque = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: torqueOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: torque == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: torque == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),
                    Text(
                      'Altura do implante/infra ósseo:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: '4',
                          groupValue: radioAltura,
                          onChanged: !editable ? null : (x){
                            setState(() {
                              radioAltura = x;
                            });
                          },
                        ),
                        Text('4mm'),
                        Radio(
                          value: '5',
                          groupValue: radioAltura,
                          onChanged: !editable ? null : (x){
                            setState(() {
                              radioAltura = x;
                            });
                          },
                        ),
                        Text('5mm'),
                        Radio(
                          value: '6',
                          groupValue: radioAltura,
                          onChanged: !editable ? null : (x){
                            setState(() {
                              radioAltura = x;
                            });
                          },
                        ),
                        Text('6mm'),
                        Radio(
                          value: '7',
                          groupValue: radioAltura,
                          onChanged: !editable ? null : (x){
                            setState(() {
                              radioAltura = x;
                            });
                          },
                        ),
                        Text('7mm'),
                      ]
                    ),

                    Text(
                      'Carga sobre Implante:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.cargas.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    carga = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: cargaOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: carga == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: carga == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text(
                      'Ancoragem primária:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.ancoragens.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    ancoragem= t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: ancoragemOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: ancoragem== t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: ancoragem== t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    Text(
                      'Sobre enxerto:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.enxerto.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    enxerto = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: enxertoOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: enxerto == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: enxerto == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),

                    SizedBox(
                      height: 44.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return RaisedButton(
                            
                            onPressed: !editable ? null : (){
                              ClientDAO paciente = model.pacienteAtual;
                              product.dataFim = DateFormat('dd/MM/yyyy').format(DateTime.now());
                              if(paciente.produtos.isEmpty)
                                paciente.produtos.add(product);
                              else{
                                if(product.tipoProduto == "Implante"){
                                  paciente.produtos.first = product;
                                }
                                else if (product.tipoProduto == "Prótese" && paciente.produtos.length == 1){
                                  paciente.produtos.add(product);
                                }
                                else {
                                  paciente.produtos[1] = product;
                                }
                              }

                              paciente.tipo = tipo;
                              paciente.conector = conector;
                              paciente.plataforma = plataforma;
                              paciente.fabricante = fabricante;
                              paciente.regiao = regiao;
                              paciente.torque = torque;
                              paciente.ancoragem = ancoragem;
                              paciente.tpPlataforma = tpPlataforma;
                              paciente.enxerto = enxerto;
                              paciente.altura = radioAltura;
                              paciente.caracteristica = caracteristica;
                              paciente.cobertura = cobertura;
                              paciente.carga = carga;
                              paciente.superficie = superficie;
                              paciente.historico += '${product.tipoProduto}:\n';
                              paciente.historico += '-Plataforma: $plataforma - $tpPlataforma;\n';
                              paciente.historico += '-Fabricante: $fabricante;\n';
                              paciente.historico += '-Torque: $torque;\n';
                              paciente.historico += '-Realizado sobre enxerto: $enxerto;\n';
                              paciente.historico += '-Data da cirurgia: ${product.dataFim};\n';
                              paciente.historico += '\n\n';

                              _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                  content: Text("${product.tipoProduto} ${model.pacienteAtual.produtos.isEmpty ? "selecionado" : "salvo"} para o paciente ${paciente.nome}!"),
                                  backgroundColor: primaryColor,
                                  duration: Duration(seconds: 1),
                                  onVisible: (){
                                    sleep(Duration(seconds: 1));
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                )
                              );
                            },
                            child: Text(
                              "${model.pacienteAtual.produtos.isEmpty ? "Selecionar" : "Salvar"} ${product.tipoProduto}", 
                              style: TextStyle(fontSize: 18),
                            ),
                            color: primaryColor,
                            textColor: Colors.white,
                          );
                        },
                      )
                    )
                  ],
                ),
              )
            ],
          ),
    );
  }

  Widget retProtese(BuildContext context){
    final primaryColor = editable ? Theme.of(context).primaryColor : Colors.green;
    return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(product.descricao),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.9,
                child: Carousel(
                  images: product.images.map((url){
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 4.0,
                  dotSpacing: 15,
                  dotBgColor: Colors.transparent,
                  dotColor: primaryColor,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Tipo:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.tipoProtese.map(
                          (t){
                            return GestureDetector(
                                onTap: (){
                                  setState((){
                                    tipo = t;
                                    UserModel.of(context).pacienteAtual.tipo = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: tipo == t ? Theme.of(context).primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: tipo == t ? Theme.of(context).primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text(
                      'Componente Protético:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.conectores.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    conector = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: conectorOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: conector == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: conector == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text(
                      'Parafuso de Cobertura:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.parafuso.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    parafuso = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: parafusoOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: parafuso == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: parafuso == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),
                    
                    SizedBox(height: 20,),

                    Text(
                      'Oclusão:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5
                        ),
                        children: product.oclusoes.map(
                          (t){
                            return GestureDetector(
                                onTap: !editable ? null : (){
                                  setState((){
                                    oclusao = t;
                                  });
                                  if (t == 'Outros'){
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                            title: Text('Especifique'),
                                            content: TextField(
                                              controller: oclusaoOutControl,
                                              onSubmitted: (s){
                                                  Navigator.of(this.context).pop();
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(this.context).pop();
                                                },
                                              )
                                            ],
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: oclusao == t ? primaryColor : Colors.grey,
                                      width: 3.0
                                    )
                                  ),
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    t,
                                    style: TextStyle(color: oclusao == t ? primaryColor : Colors.black),
                                  ),
                                ),
                              );
                          }).toList()
                      ),
                    ),
                    
                    SizedBox(height: 20,),

                    SizedBox(
                      height: 44.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return RaisedButton(
                            
                            onPressed: !editable ? null : (){
                              ClientDAO paciente = model.pacienteAtual;
                              product.dataFim = DateFormat('dd/MM/yyyy').format(DateTime.now());
                              if(paciente.produtos.isEmpty)
                                paciente.produtos.add(product);
                              else{
                                if(product.tipoProduto == "Implante"){
                                  paciente.produtos.first = product;
                                }
                                else if (product.tipoProduto == "Prótese" && paciente.produtos.length == 1){
                                  paciente.produtos.add(product);
                                }
                                else {
                                  paciente.produtos[1] = product;
                                }
                              }

                              paciente.tipo = tipo;
                              paciente.conector = conector;
                              paciente.oclusao = oclusao;
                              paciente.parafuso = parafuso;
                              paciente.historico += '${product.tipoProduto}:\n';
                              paciente.historico += '-Data da cirurgia: ${product.dataFim};\n';
                              paciente.historico += '-Conector: $conector;\n';
                              paciente.historico += '-Tipo da prótese: $tipo;\n';
                              paciente.historico += '-Parafuso de cobertura: Hexagonal;\n';
                              paciente.historico += '\n\n';

                              _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                  content: Text("${product.tipoProduto} ${model.pacienteAtual.produtos.isEmpty ? "selecionado" : "salvo"} para o paciente ${paciente.nome}!"),
                                  backgroundColor: primaryColor,
                                  duration: Duration(seconds: 1),
                                  onVisible: (){
                                    sleep(Duration(seconds: 1));
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                )
                              );
                            },
                            child: Text(
                              "${model.pacienteAtual.produtos.isEmpty ? "Selecionar" : "Salvar"} ${product.tipoProduto}", 
                              style: TextStyle(fontSize: 18),
                            ),
                            color: primaryColor,
                            textColor: Colors.white,
                          );
                        },
                      )
                    )
                  ],
                ),
              )
            ],
          ),
    );
  }
}