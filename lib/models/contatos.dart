import 'package:flutter/cupertino.dart';

class Contato {
  final String id;
  final String name ;
  final String cell;
  final String email;
  final String dtnasc;
  final bool havewats;


  const Contato ({
   this.id,
   @required this.name,
   @required this.email,
   @required this.cell,
   @required this.dtnasc,
   this.havewats
  });
}