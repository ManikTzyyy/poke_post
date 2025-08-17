// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormPokemon extends StatelessWidget {
  FormPokemon({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _abilityController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _attackController = TextEditingController();
  final TextEditingController _defenseController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();

  
Future<void> _submitForm(name, desc, type, abil, hp, attack, defense, speed) async{
  final url = Uri.parse('https://be-pokepit.vercel.app/api/create/pokemon');
  
  final body = {
    "name" : name,
    "description": desc,
    "types": type,
    "abilities": abil,
    "stats" : {
      "hp": hp,
      "attack": attack,
      "defense": defense,
      "speed": speed,
    },
    "img" : "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png"
  };

  try{
    //loading
    final response = await http.post(
    url, 
    headers: {'Content-Type': 'application/json',}, 
    body: jsonEncode(body));

    if(response.statusCode == 200 ){
      print('Data berhasil dikirim');
      print(response.body);
    } else{
      print(response.body);
      print('Gagal mengirim data');

    }
    //loading
  } catch(e){
     print('error : $e');
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildForm('Name', _nameController),
              buildForm('description', _descController),
              buildForm('type', _typeController),
              buildForm('abilities', _abilityController),
              buildForm('HP', _hpController),
              buildForm('attack', _attackController),
              buildForm('defense', _defenseController),
              buildForm('speed', _speedController),
              SizedBox(height: 20),

              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // print('data dikirim');
                    // print(_nameController.text);
                    _submitForm(
                      _nameController.text, 
                      _descController.text, 
                      _typeController.text.split(",").map((e) => e.trim()).toList(), 
                      _abilityController.text.split(",").map((e) => e.trim()).toList(), 
                      int.parse(_hpController.text), 
                      int.parse(_attackController.text), 
                      int.parse(_defenseController.text), 
                      int.parse(_speedController.text));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm(name, controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hint: Text('masukan $name'), label: Text('$name')),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Masukan beberapa kata';
        }
        return null;
      },
    );
  }
}
