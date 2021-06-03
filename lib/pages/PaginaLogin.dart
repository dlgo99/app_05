import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'PaginaLogado.dart';
import 'PaginaNovaConta.dart';
import 'CRUD.dart';

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  TextEditingController _controllerLogin = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerlogin = TextEditingController();
    TextEditingController _controllersenha = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda de Contatos"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            img ('assets/images/login.png'),
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
                    child: Text("Logar"),
                    onPressed: () async{
                      //await _validate(_controllerlogin.text, _controllersenha.text);
                      //print("validado na main $validado");
                      await validarConta(_controllerlogin.text, _controllersenha.text);
                      if(validado){
                        //if(true){
                        print("-> Menu Logado");
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaginaLogado()
                            ),
                          );
                    });       
                      }

                      else{
                        print("Conta não existe");
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: Text("Conta não existe!"),
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
                ElevatedButton(
                    child: Text("Registrar"),
                    onPressed: (){
                      setState(() {
                      print("-> Menu Registro");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaginaNovaConta()
                            ),
                          );
                    });
                    }
                ),
               /* ElevatedButton(
                    child: Text("Listar Usuarios"),
                    onPressed: (){
                      _listarUsuarios();
                    }
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
