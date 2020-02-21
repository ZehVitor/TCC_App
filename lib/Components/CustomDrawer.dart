import'package:flutter/material.dart';
import 'package:tcc_app/Components/CustomTile.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    UserModel.of(context).pageController = pageController;
    
    Widget _widgetDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey,
            Colors.white
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
    );
    
    return Drawer(
      child: Stack(
        children: <Widget>[
          _widgetDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0,
                      child: Text("Sistema de\nImplantes", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (contextModel, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Olá, ${model.isLoggedIn() ? model.loggedUser.nome : ""}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Text(
                                  "Sair",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: (){
                                  model.signOut((){
                                      Navigator.of(context).pushNamedAndRemoveUntil('/Login',
                                        (Route<dynamic> route) => false
                                      );
                                  });
                                },
                              ),
                            ],
                          );
                        }
                      )
                    ),
                  ],
                ),
              ),

              Divider(),

              CustomTile(Icons.home, "Início", pageController, 0),
              CustomTile(Icons.list, "Provisórios", pageController, 1),
              CustomTile(Icons.person_outline, "Pacientes", pageController, 2),
              CustomTile(Icons.playlist_add_check, "Minhas Consultas", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}