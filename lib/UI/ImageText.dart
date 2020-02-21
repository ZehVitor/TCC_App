import 'package:flutter/material.dart';

class ImageText extends StatelessWidget{
  
  final IconData icon;
  // double imageWidth;
  // double imageHeight;
  final String cText;
  double contWidth = 300;
  double nBorder = 20;
  VoidCallback function;

  ImageText(this.icon, this.cText, this.contWidth, this.function);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (context)=> page)
          // );
          function();
        },
        child: Container(
          width: contWidth,
          color: Colors.transparent,
          child: Material(
            elevation: 5.0,
            // color: Color.fromRGBO(200, 200, 250, 1),
            color: Color.fromARGB(90, 200, 200, 250),
            borderRadius: BorderRadius.all(Radius.circular(nBorder)),
            
            // Image + Text
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                      icon,
                      size: 32.0,
                      color: Colors.black,
                  ),
                  
                  Text(
                    cText,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black 
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
    );
  }
}