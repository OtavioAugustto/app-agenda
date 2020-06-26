import 'package:agenda_oficial/provider/contatosprv.dart';
import 'package:agenda_oficial/routes/app-routes.dart';
import 'package:agenda_oficial/viwes/contatos_list.dart';
import 'package:agenda_oficial/viwes/contato-form.dart';
import 'package:agenda_oficial/viwes/edit-contato.dart';
import 'package:agenda_oficial/viwes/vizualizar-contato.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( //definição de providers 
      providers: [
        ChangeNotifierProvider(  // cuida das alterações referentes a novos usuários, exclusão edição... 
          create: (ctx) => ContatosProvider(), //e é relacionado ao provider da classe contatospv
        )
      ],
      child: MaterialApp(
      title: 'Agenda Eletrônica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //chama as rotas definidas
      routes: { 
        AppRoutes.HOME:(_) => ListaContatos(),//chama interface de contatos_list como a home page
        AppRoutes.CONTATO_FORM: (_) => ContatoForm(), //chama interface de adicionar contatos-form
        AppRoutes.VCONTATO_FORM: (_)=> VizualizarContatoForm(), //chama interface de vizualizar contatos-form
        AppRoutes.ECONTATO_FORM: (_)=> EditContatoForm(), //chama interface de editar contatos-form
      },
    ),
  );
  }
}


