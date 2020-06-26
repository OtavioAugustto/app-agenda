import 'package:agenda_oficial/components/contatos_tile.dart';
import 'package:agenda_oficial/routes/app-routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda_oficial/provider/contatosprv.dart';
import 'dart:io';


class ListaContatos extends StatefulWidget{

  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {


  //alterado by: Otávio Augusto - 04-05-2020 - Variáveis para Implementar ações na barra de busca
  String appTitle ="Lista de Contatos";
  bool searchEnabled = false;

  //Método para trocar estado da Search Bar
  _switchSearchBarState(){
    setState(() {
      searchEnabled = !searchEnabled;
    });
  }// encerrando método Searchbar

  //filtro da barra de pesquisa
  String filterText ="";

  @override
  
  Widget build(BuildContext context){
    //importar a classe da lista mocup para pré-exibição
    final ContatosProvider contatos = Provider.of(context);

    //Estou utilizando esta maneira alternativa (Willpop) apenas para evitar de voltar quando vier da edição a partir do vizualizar.
    return new WillPopScope(
    onWillPop: () async => false,
    child: new Scaffold
    (appBar: AppBar(
      title: !searchEnabled ? Text(appTitle): // Implementando ações na barra de busca
          //barra para digitar busca
          TextField(
            style: new TextStyle(
              color: Colors.white,
            ),
            decoration: new InputDecoration(
              hintText: "Search...",
              hintStyle: new TextStyle(color:Colors.white)
              ),
            //ação para pesquisar
             onChanged: (text){

             }, 
            ),
            actions: <Widget>[
            IconButton(
              icon: Icon(searchEnabled ? Icons.close : Icons.search), //validação para mudar o ícone de pesquisa por 'X' para sair do estado.
              onPressed: () {
                _switchSearchBarState(); //chamando a função para mudar o estado da barra 
              },
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