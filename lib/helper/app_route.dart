import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/constant/strings.dart';
import 'package:flutter_breaking/data/api/charactars_api.dart';
import 'package:flutter_breaking/data/repository/charactors_repo.dart';
import 'package:flutter_breaking/presentation/screens/characeters_details.dart';
import 'package:flutter_breaking/presentation/screens/characters.dart';

class AppRoute {
  late CharactorsRepository charactorsRepository;
  late CharactersCubit charactersCubit;
  AppRoute() {
    charactorsRepository = CharactorsRepository(CharactorApi());
    charactersCubit = CharactersCubit(charactorsRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characetersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: const CharacterScreen(),
                ));

      case characeterDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const CharacterDetialsScreen());
    }
  }
}
