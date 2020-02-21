import 'package:flutter/material.dart';
import 'package:tcc_app/Components/OrderTile.dart';
import 'package:tcc_app/DAOs/ClientDAO.dart';
import 'package:tcc_app/DAOs/OrderDAO.dart';

class OrderTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClientDAO miranda = ClientDAO(0189, 'Miranda', '(84)99999-9999', "miranda@teste.com");
    OrderDAO pedido = OrderDAO(987, miranda);

    return ListView(
      children: <Widget>[
        OrderTile(pedido),
      ],
    );
  }
}