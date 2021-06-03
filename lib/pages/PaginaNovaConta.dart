import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'CRUD.dart';

class PaginaNovaConta extends StatefulWidget {
  @override
  _PaginaNovaContaState createState() => _PaginaNovaContaState();
}

class _PaginaNovaContaState extends State<PaginaNovaConta> {

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerlogin = TextEditingController();
    TextEditingController _controllersenha = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Conta"),
        centerTitle: true,
        actions: <Widget>[
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            img ('assets/images/cadastrar.png'),
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o login: ",
              ),
              controller: _controllerlogin,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Digite a senha: ",
              ),
              obscureText: true,
              controller: _controllersenha,
            ),
            SizedBox(height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    child: Text("Registrar"),
                    onPressed: () async {
                      await validarLogin(_controllerlogin.text);
                      if (await campoVazio(_controllerlogin.text, _controllersenha.text) == false
                      && validado == false){
                        //if(true){
                        cadastrar(_controllerlogin.text, _controllersenha.text);
                        print("Conta cadastrada");  
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: Text("Conta Criada!"),
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
                        print("Login ou senha não podem ficar vazios ou conta já existe");
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: Text("Login ou senha não podem ficar vazios"),
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
