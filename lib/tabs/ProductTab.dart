import 'package:flutter/material.dart';
import 'package:tcc_app/Components/CategoryTile.dart';
import 'package:tcc_app/DAOs/GrupoDAO.dart';

class ProductTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    GrupoDAO implantes = GrupoDAO(1, '123','Implantes');
    GrupoDAO proteses = GrupoDAO(2, '123','Próteses');

    return ListView(
      children: <Widget>[
        CategoryTile(implantes),
        CategoryTile(proteses)
      ],
    );
  }
}