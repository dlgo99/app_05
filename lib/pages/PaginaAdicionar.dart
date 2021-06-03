import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import 'CRUD.dart';

class PaginaAdicionar extends StatefulWidget {
  @override
  _PaginaAdicionarState createState() => _PaginaAdicionarState();
}

class _PaginaAdicionarState extends State<PaginaAdicionar> {

  //File? file;
  //UploadTask task;
  File file;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllernome       = TextEditingController();
    TextEditingController _controlleremail      = TextEditingController();
    TextEditingController _controllercep        = TextEditingController();
    TextEditingController _controllertelefone   = TextEditingController();

    final fileName = file != null ? basename(file.path) : 'Nenhuma foto selecionada';
    //final fileName = file != null ? file.path : 'Nenhuma foto selecionada';
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Contato"),
      ),
      body: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          img ('assets/images/enumerar128.png'),
          //img ('/data/user/0/lddm.app_05/cache/file_picker/IMG-20210602-WA0065.jpg'),
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

              /*
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                label: Text("Adicionar Foto"),
                icon: Icon(Icons.attach_file),
                onPressed: () async { 
                  selectFile();
                },
              ),
              SizedBox(height: 8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 25),
              */

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                        child: Text("Adicionar"),
                        onPressed: () async {
                          if (campoVazios(_controllernome.text, _controlleremail.text, 
                              _controllercep.text, _controllertelefone.text) == false){
                            //if(true){
                            await getID();
                            adicionar(_controllernome.text, _controlleremail.text, 
                                      _controllercep.text, _controllertelefone.text);
                            await setID();
                            print("Contato $idGlobal Adicionado");  
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Contato $idGlobal Adicionado!"),
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

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;
    //final path = result.files.single.path!;

    setState(() => file = File(path));
  }

}
