import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/ClientDAO.dart';
import 'package:tcc_app/DAOs/ProductDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:tcc_app/Screens/ProductScreen.dart';

class ProductTile extends StatelessWidget {
  
  final String type;
  final ProductDAO product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        ClientDAO paciente = UserModel.of(context).pacienteAtual;
        if (paciente != null && 
            (paciente.produtos.length >= 1 && paciente.produtos.first.tipoProduto == '-') 
            || (paciente.produtos.length > 1 && paciente.produtos[1].tipoProduto == '-') ){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product, true))
          );
        }
      },
      child: Card(
        child: type == "grid" ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 0.8,
                  // child: Icon(Icons.apps, size: 25.0,)
                  child: Image.network(product.images[0])
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(product.descricao),
                        Text(
                          "${product.tipoProduto}",
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
            :
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  // child: Icon(Icons.apps, size: 25.0,)
                  child: Image.network(product.images[0])
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(product.descricao, style: TextStyle(fontWeight: FontWeight.w500),),
                        Text(
                          "${product.tipoProduto}",
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