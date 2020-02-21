import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/ClientDAO.dart';
import 'package:tcc_app/DAOs/GrupoDAO.dart';
import 'package:tcc_app/DAOs/ProductDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:tcc_app/Screens/CategoryScreen.dart';
import 'package:tcc_app/Screens/ProductScreen.dart';

class ClientScreen extends StatefulWidget {
  
  final ClientDAO cliente;

  ClientScreen(this.cliente);

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  String tipo = '';
  String conector = '';
  String plataforma = '';
  String fabricante = '';
  String regiao = '';
  String torque = '';
  String ancoragem = '';
  String oclusao = '';
  String enxerto = '';
  final outrosPlatControl  = TextEditingController();
  final outrosTipoControl  = TextEditingController();

  @override
  void initState() { 
    super.initState();
    ProductDAO produto;
    ProductDAO protese;
    if(widget.cliente.produtos.isEmpty){
      produto = ProductDAO(1, 'Não Cadastrado');
      produto.tipoProduto = '-';
      widget.cliente.produtos.add(produto);
      widget.cliente.produtos.add(produto);
    } else {
      produto = widget.cliente.produtos[0];
      tipo = widget.cliente.tipo;
      conector = widget.cliente.conector;
      plataforma = widget.cliente.plataforma;
      fabricante = widget.cliente.fabricante;
      regiao = widget.cliente.regiao;
      torque = widget.cliente.torque;
      ancoragem = widget.cliente.ancoragem;
      oclusao = widget.cliente.oclusao;
      enxerto = widget.cliente.enxerto;
      if (widget.cliente.produtos.length > 1){
        protese = widget.cliente.produtos[1];
      }
      else{
        protese = ProductDAO(1, 'Não Cadastrado');
        protese.tipoProduto = '-';
        widget.cliente.produtos.add(protese);
      }
    }

    List<ClientDAO> pacientes = UserModel.of(context).pacientes;
    for (ClientDAO p in pacientes) {
      if (p.nome == widget.cliente.nome){
        UserModel.of(context).pacienteAtual = p;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductDAO produto;
    ProductDAO protese;
    if(widget.cliente.produtos.isEmpty){
      produto = ProductDAO(1, 'Não Cadastrado');
      produto.tipoProduto = '-';
      widget.cliente.produtos.add(produto);
      widget.cliente.produtos.add(produto);
    } else {
      produto = widget.cliente.produtos[0];
      if (widget.cliente.produtos.length > 1){
        protese = widget.cliente.produtos[1];
      }
      else{
        protese = ProductDAO(1, 'Não Cadastrado');
        protese.tipoProduto = '-';
        widget.cliente.produtos.add(protese);
      }
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.cliente.nome),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.account_box)),
              Tab(text: 'Implante',),
              Tab(text: 'Prótese',),
              Tab(text: 'Histórico'),
            ],
          ),
        ),
        
        body: TabBarView(
          children: <Widget>[
            // Tab 1: Dados cadastrais ------------------------------------------------------------------------------------------------------------------------------------------
            ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Text("CPF: ${widget.cliente.cpf}"),
                
                SizedBox(height: 30,),
                Text(
                  "Nome:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "  ${widget.cliente.nome}"
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black 
                    ),
                  ),
                ),
                
                SizedBox(height: 30,),
                Text(
                  "Endereco:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: " ${widget.cliente.endereco}"
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black 
                    ),
                  ),
                ),

                SizedBox(height: 30,),
                Text(
                  "Fone:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: " ${widget.cliente.fone}"
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black 
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  "Cidade:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: " ${widget.cliente.cidade}"
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black 
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  "Profissao:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: " ${widget.cliente.profissao}"
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black 
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  "Estado civil:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: " ${widget.cliente.estadoCivil}"
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black 
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  "Nascimento:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: " ${widget.cliente.nascimento}"
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black 
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  "Cadastro:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: " ${widget.cliente.dataCadastro}"
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black 
                    ),
                  ),
                ),

                SizedBox(height: 30,),

                Text(
                  "Termo de Consentimento:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Por este instrumento particular o (a) paciente ${widget.cliente.nome}, declara, para todos os fins legais, especialmente"),
                Text("do disposto no artigo 39, VI, da Lei 8.078/90 que dá plena autorização ao (à) médico(a) Gilvani inscrito(a) "),
                Text("no CRO-9999 sob o nº 9999 para proceder as investigações necessárias ao diagnóstico do seu estado de saúde"),
                
              ],
            ),

            // Tab 2 ------------------------------------------------------------------------------------------------------------------------------------------
            ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Text(produto.tipoProduto.toUpperCase() == 'IMPLANTE' ? "${produto.tipoProduto} utilizado(a):" : '- utilizado(a)'),
                Text(
                  "${produto.descricao}",
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
          
                SizedBox(height: 30,),

                Text("Tipo:", style: TextStyle(fontWeight: FontWeight.bold),),
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
                    children: produto.plataformas.map(
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
                                          controller: outrosPlatControl,
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
                
                SizedBox(height: 30,),

                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: plataforma.isEmpty ? null : (){
                      if(produto.tipoProduto == '-'){
                        GrupoDAO grupo = GrupoDAO(1, '10', 'Implantes');
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CategoryScreen(grupo))
                        );
                      }
                      else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ProductScreen(produto, false))
                        );
                      }
                    },
                    child: Text(
                      produto.tipoProduto == '-' ? 'Adicionar Provisório' : "Visualizar ${produto.descricao}", 
                      style: TextStyle(fontSize: 18),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),

            // Tab 3 ------------------------------------------------------------------------------------------------------------------------------------------
            ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Text(protese != null ? "${protese.tipoProduto} utilizado(a):" : '- utilizado(a)'),
                Text(
                  protese != null ? "${protese.descricao}" : 'Não Cadastrado',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30,),

                Text("Tipo:", style: TextStyle(fontWeight: FontWeight.bold),),
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
                    children: produto.tipoProtese.map(
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
                                          controller: outrosTipoControl,
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
          
                SizedBox(height: 30,),

                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: tipo.isEmpty ? null : (){
                      if(protese != null && protese.tipoProduto != '-'){
                        bool lEdit = false;
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ProductScreen(protese, lEdit))
                        );
                      }
                      else {
                        GrupoDAO grupo = GrupoDAO(2, '  10', 'Prótese');
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CategoryScreen(grupo))
                        );
                      }
                    },
                    child: Text(
                      protese != null && protese.tipoProduto != '-' ? "Visualizar ${protese.descricao}" : 'Adicionar Provisório', 
                      style: TextStyle(fontSize: 18),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),

            // Tab 4 ------------------------------------------------------------------------------------------------------------------------------------------
            ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Text("Histórico de procedimentos do(a) paciente ${widget.cliente.nome}"),
                Text("${widget.cliente.historico}")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
