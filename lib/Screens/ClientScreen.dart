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
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                showDialog(
                  context: this.context,
                  builder: (BuildContext context){
                    return AlertDialog(
                        title: Text('Defina o atendimento'),
                        content: SizedBox(
                            height: 100,
                            child: Column(
                              children: <Widget>[
                                Text('Data da cirurgia:'),
                                TextField(
                                    onSubmitted: (s){
                                      Navigator.of(this.context).pop();
                                    },
                                  )
                                ],
                              ),
                          ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Implante'),
                            onPressed: () {
                              GrupoDAO grupo = GrupoDAO(1, '10', 'Implantes');
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => CategoryScreen(grupo))
                              );
                            },
                          ),
                          FlatButton(
                            child: Text('Prótese'),
                            onPressed: () {
                              GrupoDAO grupo = GrupoDAO(2, '10', 'Prótese');
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => CategoryScreen(grupo))
                              );
                            },
                          )
                        ],
                    );
                  }
                );
              },
              textColor: Colors.white,
              child: Text('Realizar Atendimento'),
            )
          ],
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
                Text(produto.tipoProduto.toUpperCase() == 'IMPLANTE' ? "${produto.tipoProduto}s utilizados:" : '- utilizado(a)'),
                ListTile(
                  leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.assignment, size: 25.0,),
                  ),
                  title: Text("${produto.descricao}"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: produto == null ? null : (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductScreen(produto, false))
                    );
                  },
                )
              ],
            ),

            // Tab 3 ------------------------------------------------------------------------------------------------------------------------------------------
            ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Text(protese != null ? "${protese.tipoProduto}s utilizadas:" : '- utilizado(a)'),
                ListTile(
                  leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.assignment, size: 25.0,),
                  ),
                  title: Text("${protese.descricao}"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: protese == null || protese.tipoProduto == '-' ? null : (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductScreen(protese, false))
                    );
                  },
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
