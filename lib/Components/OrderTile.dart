import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/OrderDAO.dart';
import 'package:tcc_app/Screens/OrderScreen.dart';

class OrderTile extends StatelessWidget {
  
  final OrderDAO pedido;

  OrderTile(this.pedido);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => OrderScreen(pedido))
        );
      },
      child: Card(
        child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Icon(Icons.pie_chart, size: 32, color: Colors.black)
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${pedido.observacao}", style: TextStyle(fontWeight: FontWeight.w500),),
                          Text(
                            "R\$ ${pedido.total.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
      ),
    );
  }
}