import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'CRUD.dart';

class PaginaAtualizar extends StatefulWidget {
  @override
  _PaginaAtualizarState createState() => _PaginaAtualizarState();
}

class _PaginaAtualizarState extends State<PaginaAtualizar> {

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllernome       = TextEditingController();
    TextEditingController _controlleremail      = TextEditingController();
    TextEditingController _controllercep        = TextEditingController();
    TextEditingController _controllertelefone   = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Atualizar Contato"),
      ),
      body: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          img ('assets/images/atualizar128.png'),
          TextField(
              decoration: InputDecoration(
                labelText: "Digite o Nome: ",
              ),
              controller: _controllernome,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o e-mail: ",
              ),
              controller: _controlleremail,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP: ",
              ),
              controller: _controllercep,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o Telefone: ",
              ),
              controller: _controllertelefone,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                        child: Text("Atualizar"),
                        onPressed: () async {
                          if (campoVazios(_controllernome.text, _controlleremail.text, 
                              _controllercep.text, _controllertelefone.text) == false){
                            //if(true){
                            atualizar(_controllernome.text, _controlleremail.text, 
                            _controllercep.text, _controllertelefone.text);
                            print("Contato $id Atualizado!");  
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Contato $id Atualizado!"),
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
                            print("Não pode ter campos vazios");
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Não pode ter campos vazios"),
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
    ),
    );
  }
}