import 'package:flutter/material.dart';
import 'package:tcc_app/Components/ClientTile.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ClientTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    if (UserModel.of(context).pacientes.isEmpty)
      UserModel.of(context).initPacientes();

    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        return ListView(
          children: model.pacientes.map((p){
            return ClientTile(p, Icons.person);
          }).toList()
        );
      },
    );
  }
}
