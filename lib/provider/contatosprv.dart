//processos da agenda Remover,Editar, adicionar etc...

import 'dart:math';

import 'package:agenda_oficial/models/contatos.dart';
import 'package:flutter/material.dart';
import 'package:agenda_oficial/data/dummy-contato.dart';

class ContatosProvider with ChangeNotifier {
  final Map<String, Contato> items = {...DUMMY_CONTATOS};

  //evento sem mudanças só para listar e pegar a quantidade de contatos.

  List<Contato> get all {
    return [...items.values];
  }

  int get count{
    return items.length;
  }

  Contato byIndex(int i) {
    return items.values.elementAt(i);
  }

  //put para Adicionar ou Editar contatos
  void put(Contato contato){
    if(contato == null){
      return;
    }

    //Editar Contato ~ Validando se ele já existe ou não 
    if(contato.id !=null && contato.id.trim().isNotEmpty && items.containsKey(contato.id)){
    
      items.update(contato.id, (_) => contato);
    }else {
    
    //Adicionar Contato
    final id = Random().nextDouble().toString();
      items.putIfAbsent(id, () => Contato(
        id: id, 
        name: contato.name, 
        email: contato.email, 
        cell: contato.cell, 
        dtnasc: contato.dtnasc, 
        havewats: true,
      ),
    );
  }
    notifyListeners(); //Ao final chama o evento que irá avisar a interface que houveram alterações nos dados 
  } //final PUT

  //Exlcuir Contatos
  void remove(Contato contato){
    if(contato != null && contato.id != null){
      items.remove(contato.id);
      notifyListeners(); //Ao final chama o evento que irá avisar a interface que houveram alterações nos dados
    }
  }
}//final Remove