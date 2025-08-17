import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



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
      "speed": speed
    }
  };

  try{
    final response = await http.post(url, body: jsonEncode(body));

    if(response.statusCode == 200 ){
      print('Data berhasil dikirim');
      print(response.body);

    } else{

      print('Gagal mengirim data');

    }

  } catch(e){
    SnackBar(content: Text('Error : $e'));
  }

}

