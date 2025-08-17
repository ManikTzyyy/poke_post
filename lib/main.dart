import 'package:flutter/material.dart';
import 'package:poke_post/views/form_pokemon.dart';

void main (){
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormPokemon(),
    );
  }
}

