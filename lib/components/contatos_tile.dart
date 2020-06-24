import 'package:agenda_oficial/models/contatos.dart';
import 'package:agenda_oficial/routes/app-routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ContatosTile extends StatelessWidget{
  
  //Instância de contatos
  final Contato contatos;
  const ContatosTile(this.contatos);

  @override
  
  Widget build(BuildContext context) {
    //box de exibição dos contatos
    return ListTile(
      //circulo com a foto do usuário 
      leading: CircleAvatar(
        backgroundImage: NetworkImage('http://www.liliamribas.com.br/wp-content/uploads/2016/09/default-user-img.jpg'),
      ),
         title: Text(contatos.name), //acessa nome do contato no array de contatos
         subtitle: Text(contatos.cell),//acessa número de telefone no array de contatos
         onTap: (){
           Navigator.of(context).pushNamed( //puxa a rota pelo nome, colocando uma viwew em cima da outra com a seta para voltar.
             AppRoutes.VCONTATO_FORM,
             arguments: contatos, //trará o contato que eu quero visualizar e irá enviar os dados para o form
           );
         },
         trailing: Container(
           width:100,
            child: Row ( //linha para quebra inserir os ícones de editar e excluir
            children:<Widget>[ 
              IconButton(
                icon: Icon(Icons.edit), 
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context).pushNamed(//puxa a rota pelo nome, colocando uma viwew em cima da outra com a seta para voltar. 
                    AppRoutes.ECONTATO_FORM,
                    arguments: contatos, //enviará o contato que eu quero editar e irá enviar os dados para o form
                   );
                  },
                ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red, 
                onPressed: () {},
                ),
         ]),
      )
    );
  }
}