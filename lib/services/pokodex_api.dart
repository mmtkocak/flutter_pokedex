import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokemon_model.dart';

class PokeApi {
  static const String _url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  static Future<List<PokemonModel>> getPokemonData() async {
    List<PokemonModel> _list = [];

    try {
      var result = await Dio().get(_url);
      // Ham JSON verisini konsola yazdırarak kontrol edin
      debugPrint('Ham veri: ${result.data}');

      var pokeList = jsonDecode(result.data)['pokemon'];

      // Null kontrolü ekleyin
      if (pokeList != null && pokeList is List) {
        _list = pokeList.map((e) => PokemonModel.fromMap(e)).toList();
      } else {
        debugPrint('pokeList null veya List değil');
        return [];
      }

      debugPrint(_list.first.toString());
    } catch (e) {
      debugPrint('Hata: $e');
      return [];
    }

    return _list;
  }
}
