import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Success extends StatefulWidget {
  const Success({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  //bool _visible = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        
        //title: new Text(widget.title, textAlign: TextAlign.center),
      ),
      body: Container(
         padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Operación Exitosa",
              style: TextStyle(
                
                  
                  fontSize: 30, fontWeight:
                  FontWeight.bold,
                  backgroundColor: Colors.greenAccent,
                  
                  color: Colors.white),
                  textAlign: TextAlign.center,
                  
                  
                  
                  
          ),
                   

          ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(
                    context, '/'
                    
                );
              },
              child: Text("REGRESAR AL FORMULARIO"))
        ],
      ),
    ));
    
  }
}
