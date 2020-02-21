import 'package:flutter/widgets.dart';
import 'package:tcc_app/DAOs/OrderDAO.dart';
import 'package:tcc_app/DAOs/ProductDAO.dart';
import 'package:tcc_app/Models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderModel extends Model {
  
  final UserModel userModel;
  bool isLoading = false;
  OrderDAO pedido;

  OrderModel(this.userModel);

  static OrderModel of (BuildContext context) =>
      ScopedModel.of<OrderModel>(context);

  void addItem(ProductDAO produto){
    this.pedido.addProduct(produto);
  }
  
  void removeItem(ProductDAO produto){
    this.pedido.removeProduct(produto);
  }
}
