import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/OrderDAO.dart';
import 'package:tcc_app/Models/OrderModel.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderScreen extends StatefulWidget {

  OrderDAO pedido;

  OrderScreen(this.pedido);

  @override
  _OrderScreenState createState() => _OrderScreenState(pedido);
}

class _OrderScreenState extends State<OrderScreen> {
  
  final OrderDAO pedido;
  
  _OrderScreenState(this.pedido);
  
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
          appBar: AppBar(
            // title: Text("${pedido.codigo}"),
            title: Text("Pedido"),
            centerTitle: true,
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.only(right: 8.0),
                child: ScopedModelDescendant<OrderModel>(
                  builder: (context, child, model){
                    model.pedido = pedido;
                    int qtd = 0;
                    if (model.pedido.produtos != null){
                      qtd = model.pedido.produtos.length;
                    }
                    
                    return Text(
                      "${qtd ?? 0} ${qtd == 1 ? "ITEM" : "ITENS"}",
                      style: TextStyle(fontSize: 17),
                    );
                  },
                ),
              )
            ],
          ),
          body: ScopedModelDescendant<OrderModel>(
            builder: (context, child, model){
              if (model.isLoading && UserModel.of(context).isLoggedIn()){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (!UserModel.of(context).isLoggedIn()){
                return Center(
                  child: Text(
                    "Faça o login para acessar os pedidos!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              else if (model.pedido.produtos == null || model.pedido.produtos.length == 0){
                return Center(
                  child: Text(
                    "Nenhum produto selecionado!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          pedido.observacao,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),
                          maxLines: 3,
                        ),
                        Text(
                          "Total R\$ ${pedido.total.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryColor
                          ),
                          maxLines: 3,
                        ),

                        SizedBox(height: 20,),

                        SizedBox(
                          height: 44.0,
                          child: RaisedButton(
                            onPressed: (){},
                            child: Text(
                              "Salvar Pedido", 
                              style: TextStyle(fontSize: 18),
                            ),
                            color: primaryColor,
                            textColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          )
    );
  }
}