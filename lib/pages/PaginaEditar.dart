import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'CRUD.dart';
import'paginaAtualizar.dart';

class PaginaEditar extends StatefulWidget {
  @override
  _PaginaEditarState createState() => _PaginaEditarState();
}

class _PaginaEditarState extends State<PaginaEditar> {

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerid         = TextEditingController();
    TextEditingController _controllernome       = TextEditingController();
    TextEditingController _controlleremail      = TextEditingController();
    TextEditingController _controllerendereco   = TextEditingController();
    TextEditingController _controllercep        = TextEditingController();
    TextEditingController _controllertelefone   = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Contato"),
      ),
      body: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          img ('assets/images/atualizar256.png'),
          TextField(
              decoration: InputDecoration(
                labelText: "Digite o id: ",
              ),
              controller: _controllerid,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                        child: Text("Atualizar"),
                        onPressed: () async{
                          if (_controllerid.text.isEmpty == false){
                            await receberId(_controllerid.text);
                            await validarID();
                          }
                          if (_controllerid.text.isEmpty == false && validado){
                            print("-> Pagina Atualizar");
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaginaAtualizar()
                                ),
                              );
                        });  
                        }
                        else{
                          print("ID invalido");
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                              return AlertDialog(
                                content: Text("ID invalido"),
                                actions: <Widget>[
                                  RaisedButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      print("OK");
                                    }
                                  )
                                ],
                              );
                            },
                          ); 
                        }
                        }
                    ),
              Padding(padding: EdgeInsets.all(10.0),),
              ElevatedButton(
                child: Text("Deletar"),
                onPressed: () async {
                      if (_controllerid.text.isEmpty == false){
                            await receberId(_controllerid.text);
                            await validarID();
                          }
                      if (_controllerid.text.isEmpty == false && validado){
                        print("Contato $id Deletadado");
                        excluir();
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: Text("Contato $id Deletado!"),
                              actions: <Widget>[
                                RaisedButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    print("OK");
                                  }
                                )
                              ],
                            );
                          },
                        );                     
                      }
                      else {
                        print("ID invalido");
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: Text("ID invalido"),
                              actions: <Widget>[
                                RaisedButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    print("OK");
                                  }
                                )
                              ],
                            );
                          },
                        );  
                      }
                    }
                    ),
            ],
          ),
        ],
      ),


      /*bottomNavigationBar: BottomAppBar(
        //shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
                icon:Icon(Icons.add) ,
                onPressed: (){
                }
            ),
          ],
        ),

      ),*/
    ),
    );
  }
}
