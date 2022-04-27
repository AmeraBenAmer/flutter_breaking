import 'package:flutter/cupertino.dart';
import 'package:flutter_breaking/data/api/charactars_api.dart';
import 'package:flutter_breaking/data/models/characters.dart';

class CharactorsRepository {
  final CharactorApi charactorApi;
  CharactorsRepository(this.charactorApi);

  Future<List<Character>> getAllCharactor() async {
    final charactors = await charactorApi.getAllCharactors();
    return charactors
        .map((charactor) => Character.fromJson(charactor))
        .toList();
  }
}
