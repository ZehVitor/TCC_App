import 'package:flutter/material.dart';
import 'package:tcc_app/DAOs/ClientDAO.dart';
import 'package:tcc_app/Screens/ClientScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientTile extends StatelessWidget {
  
  //Pegar dados do json da Rota
  final ClientDAO cliente;
  IconData icon;

  ClientTile(this.cliente, this.icon);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value){
        if (value == "call"){
          launch("tel://${cliente.fone}");
        }
        else if (value == "msg") {
          launch("whatsapp://send?phone=${cliente.fone}");
        } else if (value == "mail") {
          launch("mailto://${cliente.email}");
        } 
        else{
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> ClientScreen(cliente))
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'call',
          child: Text('Ligar'),
        ),
        const PopupMenuItem<String>(
          value: 'msg',
          child: Text('Enviar Mensagem'),
        ),
        const PopupMenuItem<String>(
          value: 'mail',
          child: Text('Enviar Email'),
        ),
        const PopupMenuItem<String>(
          value: 'details',
          child: Text('Detalhes'),
        ),
      ],

      child: ListTile(
        leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.transparent,
            child: Icon(icon, size: 32, color: Colors.black),
        ),
        title: Text("${cliente.nome}\n${cliente.fone}"),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> ClientScreen(cliente))
          );
        },
      ),
    );
  }
}