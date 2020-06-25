import 'package:agenda_oficial/models/contatos.dart';
import 'package:agenda_oficial/provider/contatosprv.dart';
import 'package:agenda_oficial/routes/app-routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:email_validator/email_validator.dart'; //DEU PROBLEMA !!

class EditContatoForm extends StatelessWidget {
  
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

  // DEU PROBLEMA NA IMPLEMENTAÇÃO
  // // Validação do campo e-mail
  // String _validarEmail(String value) {
  //   if(!EmailValidator.Validate(value, true)) {
  //     return 'E-mail inválido!';
  //   } else {
  //     return null;
  //   }
  // }

  //metodo para carregar os dados de contato para edição.
  void _loadFormData(Contato contato){
    if(contato != null){
       _formData['id'] = contato.id;
       _formData['name'] = contato.name;
       _formData['email'] = contato.email;
       _formData['dtnasc'] = contato.dtnasc;
       _formData['cell'] = contato.cell;
      //  _formData['havewats'] = contato.havewats as String; Ajustar primeiro o set state antes de utilizar
    }
  }

  
  @override

  Widget build(BuildContext context){

    final Contato contato = ModalRoute.of(context).settings.arguments; // instância para identificar o contato clicado

    _loadFormData(contato); // carrega métodoque traz os dados do contato.

    return Scaffold(  
      appBar: AppBar(
        title: Text('Editar Contato'),
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
                  decoration:  InputDecoration(hintText: 'Nome completo'),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  focusNode: nomeIndex,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, nomeIndex, emailIndex);
                  },       
                  // validações           
                   validator: (value) {
                     if(value == null || value.trim().isEmpty){
                     return 'Este campo não pode estar vazio!';
                     }
                     return null;
                   },
                   onSaved: (value) => _formData['name'] = value,
                ),
                
                Text('\n', textScaleFactor: 0.5,),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: new InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: emailIndex,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, emailIndex, nascIndex);
                 },
                  // validações           
                   validator: (value) {
                    if(value == null || value.trim().isEmpty){
                     return 'Este campo não pode estar vazio!';  // precisando ajustar o uso do email validator
                     }
                     return null;
                   },
                  onSaved: (value) => _formData['email'] = value, 
                 ),

                Text('\n', textScaleFactor: 0.5,),
                TextFormField(
                  initialValue: _formData['dtnasc'],
                  decoration: new InputDecoration(hintText: 'Data de nascimento'),
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  focusNode: nascIndex,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, nascIndex, cellIndex);
                 },
                  // validações           
                   validator: (value) {
                    if(value == null || value.trim().isEmpty){
                     return 'Este campo não pode estar vazio!';  //OBS: PRECISA DE AJUSTE NA QUESTÃO DO EMAIL VALIDATOR
                     }
                     return null;
                   },
                     onSaved: (value) => _formData['dtnasc'] = value,
                ),

                Text('\n', textScaleFactor: 0.5,),
                TextFormField(
                  initialValue: _formData['cell'],
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

                Text('\n', textScaleFactor: 0.5,),
                Text('Possui Whats ?', textScaleFactor: 1.2,),
                Text('Verde para SIM ou deixe Cinza para NÃO'),
                Switch(
                  value: stPossuiWhats,
                  onChanged: (value) { //OBS: PRECISA DE AJUSTE NA QUESTÃO DO SET STATE
                    //  setState(() {
                    //     _formData['havewats'] = stPossuiWhats;
                    //    stPossuiWhats = value;
                    //  });
                  },
                  activeTrackColor: Colors.lime, 
                  activeColor: Colors.lightGreen,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 34.0),
                    child: RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: (){
                       final isValid = _formKey.currentState.validate();
                       if(isValid){
                          _formKey.currentState.save();

                          Provider.of<ContatosProvider>(context, listen: false).put(  // envia as informações de usuários
                            Contato(
                             id: _formData['id'],
                             name: _formData[ 'name'],
                             email: _formData[ 'email'],
                             dtnasc: _formData[ 'dtnasc'], 
                             cell: _formData[ 'cell'],
                             havewats:true, //ajustar depois
                          ),
                        );
                          Navigator.of(context).pushNamed(
                            AppRoutes.HOME
                          );
                       }
                      },//adicionarContato,
                    child: Text('Salvar', textScaleFactor: 1.4,),
                  ),
                )
              ],
          )
        ),
        ),
      ),
    );
  }
}