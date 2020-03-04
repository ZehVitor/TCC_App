import 'package:flutter/material.dart';
import 'package:tcc_app/Components/CustomDrawer.dart';
import 'package:tcc_app/DAOs/OrderDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:tcc_app/Screens/AddClientScreen.dart';
import 'package:tcc_app/Screens/AddProductScreen.dart';
import 'package:tcc_app/tabs/ClientTab.dart';
import 'package:tcc_app/tabs/HomeTab.dart';
import 'package:tcc_app/tabs/OrderTab.dart';
import 'package:tcc_app/tabs/ProductTab.dart';

class HomeScreen extends StatelessWidget {
  
  final PageController _pageController = PageController();
  OrderDAO pedido;

  @override
  Widget build(BuildContext context) {
    UserModel.of(context).pageController = _pageController;
    
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        // Categorias
        Scaffold(
          appBar: AppBar(
                    title: Text(
                    'Categorias',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.white
                      ),
                    ),
                    centerTitle: true,
          ),
          body: HomeTab(_pageController),
          drawer: CustomDrawer(_pageController),
        ),

        // Produtos
        Scaffold(
          appBar: AppBar(
                    title: Text(
                    'Consulta',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.white
                      ),
                    ),
                    centerTitle: true,
                    actions: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddProductScreen())
                          );
                        },
                        textColor: Colors.white,
                        child: Text('Novo'),
                      )
                    ],
          ),
          body: ProductTab(),
          drawer: CustomDrawer(_pageController),
        ),

        // Clientes
        Scaffold(
          appBar: AppBar(
                    title: Text(
                    'Pacientes',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.white
                      ),
                    ),
                    centerTitle: true,
                    actions: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddClientScreen())
                          );
                        },
                        textColor: Colors.white,
                        child: Text('Novo Paciente'),
                      )
                    ],
          ),
          body: ClientTab(),
          drawer: CustomDrawer(_pageController),
        ),

        // Pedido
        Scaffold(
          appBar: AppBar(
                    title: Text(
                    'Consultas',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.white
                      ),
                    ),
                    centerTitle: true,
          ),
          body: OrderTab(),
          drawer: CustomDrawer(_pageController),
        ),
        
      ],
    );
  }
}