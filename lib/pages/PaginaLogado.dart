import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'CRUD.dart';
import 'PaginaAdicionar.dart';
import 'paginaEditar.dart';

File _image;
var _images = new List(100);

class PaginaLogado extends StatefulWidget {
  @override
  _PaginaLogadoState createState() => _PaginaLogadoState();
}

class _PaginaLogadoState extends State<PaginaLogado> {
  //List _listaCompras = ["Pão", "Leite", "Manteiga"];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Contatos"),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked, //usar com o BottomNavigationBar
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          elevation: 6,
          child: Icon(Icons.update),
          onPressed: () async {
            lista = "\n";
            await lerTodos2();
            print("Botão pressionado!");
            print ("Botão: ------------ \n"+lista);
            showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              //content: Text(lista),
                              content: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          //key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //img ('assets/images/atualizar128.png'),
              for (int i = 0; i < qtd2; i++)
                Row(
                  children: <Widget>[
                    //img2('assets/images/default.png'),
                    //-----------------------------------------------------
                    GestureDetector (
                      onTap: () async {
                        await getImage(i);
                        //_images[qtd2] = _image;
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffFDCF09),
                        //child: _image != null
                        child: _images[i] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  //_image,
                                  _images[i],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                    //-----------------------------------------------------
                    Padding(padding: EdgeInsets.all(8.0)),
                    Expanded(child: Text(lista2[i]),),
                  ],
                ),
            ],
          ),
        )),
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
      ),
      body: Column(
        children: <Widget>[
          img ('assets/images/logado.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                        child: Text("Adicionar"),
                        onPressed: () async{
                            print("-> Pagina Adicionar");
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaginaAdicionar()
                                ),
                              );
                        });       
                        }
                    ),
              Padding(padding: EdgeInsets.all(10.0),),
              ElevatedButton(
                        child: Text("Editar"),
                        onPressed: () async{
                            print("-> Pagina Editar");
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaginaEditar()
                                ),
                              );
                        });       
                        }
                    ),
            ],
          ),
          //textInfo(lista),
          /*
          Expanded(
            child: ListView.builder(
                itemCount: _listaCompras.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(_listaCompras[index]),
                  );
                }
            ),
          ),
          */
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
    );
  }

  Future getImage(int i) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        //_image = File(pickedFile.path);
        _images[i] = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

}
