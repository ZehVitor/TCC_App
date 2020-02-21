import 'package:flutter/material.dart';

class IconInput extends StatelessWidget{
  
  Icon iconField;
  String hintText;
  bool isPass;
  TextEditingController textControl;
  double nWidth = 300;
  double nBorder = 10;

  IconInput(this.iconField,this.hintText, this.isPass, this.textControl);

  IconInput.Aditionals(this.iconField,this.hintText, this.isPass, this.textControl, double nWidth, double nBorder){
    this.nWidth = nWidth;
    this.nBorder = nBorder;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
                  width: nWidth,
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(nBorder)),
                    
                    // Icon + Text
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: iconField,
                        ),
                        
                        // Container setted just for organize the width
                        Container(
                          width: 250,
                          child: TextField(
                            obscureText: isPass,
                            controller: textControl,
                            decoration: InputDecoration(
                              hintText: hintText
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
  }
}