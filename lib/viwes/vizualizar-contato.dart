import 'package:agenda_oficial/models/contatos.dart';
import 'package:agenda_oficial/routes/app-routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VizualizarContatoForm extends StatelessWidget {
  
 final _formKey = GlobalKey<FormState>();// chave do form
  final Map<String, String> _formData ={}; // objeto que recebe os dados do form
  
   // Variáveis que controla o Tab Index no formulário
  final FocusNode nomeIndex = FocusNode();  
  final FocusNode emailIndex = FocusNode();  
  final FocusNode nascIndex = FocusNode();
  final FocusNode cellIndex = FocusNode();  
  final FocusNode possuiWhatsIndex = FocusNode();

  //Método que Controla o TabIndex
  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }

  final bool stPossuiWhats = true; // variável par situação do marcador de wats

   // Validação do campo Celular
  String _validarCelular(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length <= 0) {
      return "Digite o nº do celular com o DDD";
    } else if(value.length != 11){
      return "O nº do celular deve ter 11 dígitos";
    }else if (!regExp.hasMatch(value)) {
      return "O número do celular só deve conter dígitos";
    }
    return null;  
  }

  //controlar texto de situação do wats
  TextEditingController haveWhatsController = TextEditingController();

  //metodo para carregar os dados de contato para edição.
  void _loadFormData(Contato contato){
    if(contato != null){
       _formData['id'] = contato.id;
       _formData['name'] = contato.name;
       _formData['email'] = contato.email;
       _formData['dtnasc'] = contato.dtnasc;
       _formData['cell'] = contato.cell;
      //  _formData['havewats'] = contato.havewats as String;
       if((contato.havewats == false) || (contato.havewats==null)) {
          haveWhatsController = TextEditingController()..text = 'Não';
          } else {
          haveWhatsController = TextEditingController()..text = 'Sim';
          }
    }
  }


  
  @override

  Widget build(BuildContext context){

    final Contato contato = ModalRoute.of(context).settings.arguments; // instância para identificar o contato clicado

    _loadFormData(contato); // carrega métodoque traz os dados do contato.

    return Scaffold(  
      appBar: AppBar(
        title: Text('Vizualizar Contato'),
      ),
      body:SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: Container(
            width: 400,
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            //campos do formulário de cadastro 
            Text('\n', textScaleFactor: 0.5,),
                TextFormField(
                  initialValue: _formData['name'],
                  enabled: false,
                  decoration:  InputDecoration(hintText: 'Nome completo'),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  focusNode: nomeIndex,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, nomeIndex, emailIndex);
                  },       
                ),
                
                Text('\n', textScaleFactor: 0.5,),
                TextFormField(
                  initialValue: _formData['email'],
                  enabled: false,
                  decoration: new InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: emailIndex,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, emailIndex, nascIndex);
                 },
                ),

                Text('\n', textScaleFactor: 0.5,),
                TextFormField(
                  initialValue: _formData['dtnasc'],
                  enabled: false,
                  decoration: new InputDecoration(hintText: 'Data de nascimento'),
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  focusNode: nascIndex,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, nascIndex, cellIndex);
                 },

                ),

                Text('\n', textScaleFactor: 0.5,),
                TextFormField(
                  initialValue: _formData['cell'],
                  enabled: false,
                  decoration: new InputDecoration(hintText: 'Celular'),
                  validator: _validarCelular,
                  textInputAction: TextInputAction.next,
                  focusNode: cellIndex,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, cellIndex, possuiWhatsIndex);
                  },                  

                  keyboardType: TextInputType.phone,
                  onSaved: (value) => _formData['cell'] = value,
                ),

                Text('\nPossui Whats?', textScaleFactor: 1,),
                TextFormField(
                  controller: haveWhatsController,
                  enabled: false,
                ),
              ],
          )
        ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.mode_edit),
            onPressed: () {
              //navegar para tela de adicionar contatos.
              Navigator.of(context).pushNamed(//puxa a rota pelo nome, colocando uma viwew em cima da outra com a seta para voltar. 
                AppRoutes.ECONTATO_FORM,
                arguments: contato,
              );
            },
        ),
    );
  }
}