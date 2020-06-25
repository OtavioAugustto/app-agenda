import 'package:agenda_oficial/components/contatos_tile.dart';
import 'package:agenda_oficial/routes/app-routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_oficial/provider/contatosprv.dart';
import 'dart:io';

class ListaContatos extends StatelessWidget{

  @override
  
  Widget build(BuildContext context){
    //importar a classe da lista mocup para pré-exibição
    final ContatosProvider contatos = Provider.of(context);

    //Estou utilizando esta maneira alternativa (Willpop) apenas para evitar de voltar quando vier da edição a partir do vizualizar.
    return new WillPopScope(
    onWillPop: () async => false,
    child: new Scaffold
    (appBar: AppBar(
      title: Text('Lista de Contatos'),
       actions: <Widget>[   
            IconButton( //Botão de Pesquisa
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton( //Botão para saír da aplicação
              icon: Icon(Icons.exit_to_app),
              tooltip: 'Sair',
                onPressed: ()=> exit(0)),
          ],
      ),
      body: ListView.builder(
        itemCount: contatos.count,
        itemBuilder: (ctx, i) => ContatosTile(contatos.byIndex(i)),
      ),

        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.person_add),
            onPressed: () {
              //navegar para tela de adicionar contatos.
              Navigator.of(context).pushNamed(//puxa a rota pelo nome, colocando uma viwew em cima da outra com a seta para voltar. 
                AppRoutes.CONTATO_FORM
              );
            },
        ),
    )
  );
  }

}