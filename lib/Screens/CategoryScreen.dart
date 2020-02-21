import 'package:flutter/material.dart';
import 'package:tcc_app/Components/ProductTile.dart';
import 'package:tcc_app/DAOs/GrupoDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoryScreen extends StatelessWidget {
  
  final GrupoDAO category;
  
  CategoryScreen(this.category);

  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).implantes.isEmpty){
      UserModel.of(context).initProducts();
    }
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.descricao),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return TabBarView(
          children: <Widget>[
                // Grid Orientation
                GridView.builder(
                  padding: EdgeInsets.all(4.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.65
                  ),
                  itemCount: category.id == 1 ? model.implantes.length : model.proteses.length, //dar um count no array de produtos
                  itemBuilder: (context, index){
                    return ProductTile('grid', category.id == 1 ? model.implantes[index] : model.proteses[index]);
                  },
                ),
                
                // List Orientation
                ListView.builder(
                  padding: EdgeInsets.all(4.0),
                  itemCount: category.id == 1 ? model.implantes.length : model.proteses.length, //dar um count no array de produtos
                  itemBuilder: (context, index){
                    return ProductTile('list', category.id == 1 ? model.implantes[index] : model.proteses[index]);
                  },
                ),
              ],
            );
          },
        )
      ),
    );
  }
}
