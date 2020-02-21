import 'package:flutter/material.dart';

class MultChoices extends StatelessWidget {
  final String _key;
  final List<String> _Opts;
  final VoidCallback function;

  MultChoices(this._key, this._Opts, this.function);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: GridView(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.5
        ),
        children: _Opts.map(
          (t){
            return GestureDetector(
                onTap: (){
                  function();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(
                      color: _key == t ? Theme.of(context).primaryColor : Colors.grey,
                      width: 3.0
                    )
                  ),
                  width: 150,
                  alignment: Alignment.center,
                  child: Text(
                    t,
                    style: TextStyle(color: _key == t ? Theme.of(context).primaryColor : Colors.black),
                  ),
                ),
              );
          }).toList()
      ),
    );
  }
}
