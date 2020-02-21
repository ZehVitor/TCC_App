import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {

  final BuildContext context;
  final String title;
  final String msg;

  CustomAlert({@required this.context,@required this.title,@required this.msg});

  @override
  Widget build(BuildContext context) {
    showDialog(
      context: this.context,
      builder: (BuildContext context){
        return AlertDialog(
            title: Text(this.title),
            content: Text(this.msg),
            actions: <Widget>[
              FlatButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(this.context).pop();
                },
              )
            ],
        );
      }
    );
  }
}
