import 'package:flutter/material.dart';
import 'package:tcc_app/Screens/AddClientScreen.dart';
import 'package:tcc_app/Screens/homeScreen.dart';
import 'package:tcc_app/UI/ImageText.dart';

class HomeTab extends StatefulWidget {
  final PageController pageController;
  
  HomeTab(this.pageController);

  @override
  _HomeTabState createState() => _HomeTabState(pageController);

}

class _HomeTabState extends State<HomeTab> {
  final PageController pageController;
  final searchControl = TextEditingController();

  _HomeTabState(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Image.network('http://onlinesites.com.br/imagens/73/5-tecnicas-de-fechamento-de-vendas-que-voce-precisa-conhecer_281120171130530.jpg'),
        Scaffold(
          body: Container(
            width: 500,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueGrey,
                    Colors.white
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                  // IconInput.Aditionals(
                  //         Icon(Icons.search, color: Colors.blue),
                  //         'Pesquisar Categoria',
                  //         false,
                  //         searchControl,
                  //         350,
                  //         20
                  // ),

                  Text(
                    'Área Administrativa',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ImageText(
                        Icons.person,
                        'Cadastrar',
                        110,
                        (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddClientScreen())
                          );
                        }
                      ),
                      ImageText(
                        Icons.list,
                        'Outros',
                        100,
                        (){
                          if (pageController.positions.isEmpty){
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context)=> HomeScreen())
                            );
                          }
                          else{
                            pageController.jumpToPage(1);
                          }
                        }
                      ),
                      ImageText(
                        Icons.settings,
                        'Config.',
                        100,
                        (){
                          pageController.jumpToPage(0);
                        }
                      ),
                    ],
                  ),
                ],
              ),
          ),
        ),
      ],
    );
  }
}
