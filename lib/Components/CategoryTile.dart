import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/GrupoDAO.dart';
import 'package:tcc_app/Screens/CategoryScreen.dart';

class CategoryTile extends StatelessWidget {
  
  //Pegar dados do json da Rota
  final GrupoDAO category;

  CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.transparent,
          child: Icon(Icons.apps, size: 25.0,),
      ),
      title: Text(category.descricao),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> CategoryScreen(category))
        );
      },
    );
  }
}