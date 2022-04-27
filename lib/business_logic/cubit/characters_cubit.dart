import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/data/repository/charactors_repo.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactorsRepository charactorsRepository;
  List<Character>? charactors;

  CharactersCubit(this.charactorsRepository) : super(CharactersInitial());

  List<Character> getAllCharactors() {
    charactorsRepository.getAllCharactor().then((charactors) {
      emit(CharactersLoaded(charactors));
      this.charactors = charactors;
    });
    return charactors!;
  }
}
