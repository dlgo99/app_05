import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

int idGlobal = 0;   // sempre muda
int id = 0;  // muda dependendo do que for preciso
bool validado = false;
String lista = "Nada na lista";

//guardar o contato da agenda e sua foto equivalente
var lista2 = new List(100);
var fotos2 = new List(100);
int qtd2 = 0;

receberId(String x) {
  id = int.parse(x);
  print("Recebido ID: $id");
}

  img(var imagem){
    return Image.asset(
      imagem,
      //    width: 100,
      // height: 100,
      fit: BoxFit.fill,
    );
  }

  img2(var imagem){
    return Image.asset(
      imagem,
      width: 100,
      height: 100,
      //fit: BoxFit.fill,
    );
  }

  textInfo(var mensagem) {
    return Text(
      mensagem,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 18.0),
    );
  }

  bool campoVazio(String a, String b) {
    bool resp = false;
    if (a.isEmpty || b.isEmpty) {
      resp = true;
    }
    return resp;
  }

  bool campoVazios(String a, String b, String c, String d) {
    bool resp = false;
    if (a.isEmpty || b.isEmpty || c.isEmpty || d.isEmpty) {
      resp = true;
    }
    return resp;
  }

    CollectionReference cadastro = FirebaseFirestore.instance.collection('cadastro');
    CollectionReference agenda = FirebaseFirestore.instance.collection('agenda');
    CollectionReference nextID = FirebaseFirestore.instance.collection('nextID');
    
    cadastrar(String login, String senha) {
      return cadastro
          .add({
            'login': login,
            'senha': senha,
            'excluido': false,
          })
          .then((value) => print("Usuario Cadastrado"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    adicionar(String nome, String email, String cep, String telefone) async {
      String endereco = "";
      var uri = Uri.parse("https://viacep.com.br/ws/${cep}/json/");
      http.Response response;
      response = await http.get(uri);
      Map<String, dynamic> retorno = json.decode(response.body);
      endereco = ""+endereco+""+retorno["logradouro"]+", "+retorno["bairro"]+", "
                   +retorno["localidade"]+", "+retorno["uf"];
      return agenda
          .doc(idGlobal.toString())
          .set({
            'id': idGlobal,
            'nome': nome,
            'email': email,
            'cep': cep,
            'endereco': endereco,
            'telefone': telefone,
            'excluido': false,
          })
          .then((value) => print("Contato Adicionado"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    atualizar(String nome, String email, String cep, String telefone) async {
      String endereco = "";
      var uri = Uri.parse("https://viacep.com.br/ws/${cep}/json/");
      http.Response response;
      response = await http.get(uri);
      Map<String, dynamic> retorno = json.decode(response.body);
      endereco = ""+endereco+""+retorno["logradouro"]+", "+retorno["bairro"]+", "
                   +retorno["localidade"]+", "+retorno["uf"];
      return agenda
        .doc(id.toString())
        .update({
            'nome': nome,
            'email': email,
            'cep': cep,
            'endereco': endereco,
            'telefone': telefone,
            'excluido': false,
            })
        .then((value) => print("Contato Atualizado"))
        .catchError((error) => print("Failed to update user: $error"));
}

excluir() {
      return agenda
        .doc(id.toString())
        .update({'excluido': true,})
        .then((value) => print("Contato Excluido"))
        .catchError((error) => print("Failed to update user: $error"));
}

lerTodos() async {
  //print(doc["id"] + doc["nome"] + doc["email"] + doc["endereco"] + doc["cep"] + doc["telefone"]);
  lista = "";
    await FirebaseFirestore.instance
    .collection('agenda')
    .where('excluido', isEqualTo: false)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            //print(doc["id"] + doc["nome"] + doc["email"] + doc["endereco"] + doc["cep"] + doc["telefone"]);
            lista = (""+lista+"\nID: " + doc["id"].toString() + "\nNome: " + doc["nome"]  + "\nE-mail: " + doc["email"] + 
            "\nCep: " + doc["cep"]  + "\nEndereco: " + doc["endereco"]  + "\nTelefone: " + doc["telefone"] 
            + "\n");
        }
        );
    });
}

lerTodos2() async {
  qtd2 = 0;
    await FirebaseFirestore.instance
    .collection('agenda')
    .where('excluido', isEqualTo: false)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            lista2[qtd2] = ("ID: " + doc["id"].toString() + "\nNome: " + doc["nome"]  + "\nE-mail: " + doc["email"] + 
            "\nCep: " + doc["cep"]  + "\nEndereco: " + doc["endereco"]  + "\nTelefone: " + doc["telefone"] 
            + "\n");
          qtd2++;
        }
        );
    });
}

getID() async {
    await FirebaseFirestore.instance
    .collection('nextID')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            idGlobal = (doc["id"]);
            //idGlobal++;
        }
        );
    });
}

setID() {
      return nextID
        .doc("id")
        .update({
            'id': idGlobal+1
            })
        .then((value) => print("Contato Atualizado"))
        .catchError((error) => print("Failed to update user: $error"));
}

validarConta(String x, String y) async {
    validado = false;
    await FirebaseFirestore.instance
    .collection('cadastro')
    .where('excluido', isEqualTo: false)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            if (x == doc["login"] && y == doc["senha"])
              validado = true;
        }
        );
    });
}

validarLogin(String x) async {
    validado = false;
    await FirebaseFirestore.instance
    .collection('cadastro')
    .where('excluido', isEqualTo: false)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            if (x == doc["login"])
              validado = true;
        }
        );
    });
}

validarID() async {
    validado = false;
    await FirebaseFirestore.instance
    .collection('agenda')
    .where('excluido', isEqualTo: false)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            if (id == doc["id"])
              validado = true;
        }
        );
    });
}