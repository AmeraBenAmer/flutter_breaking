import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/constant/color_theme.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/presentation/widgets/characterItem.dart';


class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  List<Character>? allCharacter;
  List<Character>? searchedForCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: Colors.grey,
      decoration: const InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(color: ThemeColor.gray, fontSize: 18),
      ),
      style: const TextStyle(color: ThemeColor.gray, fontSize: 18),
      onChanged: (searchedCharacters) {
        addSearchedForItemToSearchedList(searchedCharacters);
      },
    );
  }

  void addSearchedForItemToSearchedList(String searchedCharacters) {
    searchedForCharacters = allCharacter!
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacters))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBasAction() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: ThemeColor.gray,
            ))
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: ThemeColor.gray,
          ),
        )
      ];
    }
  }

  void _startSearch() {
    // نخلي البرنامج يفترض انه أنا انتقلت لشاشة تانية ويحط زر رجوع
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharactors();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacter = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showProgressLoading();
      }
    });
  }

  Widget showProgressLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: ThemeColor.yellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: ThemeColor.gray,
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchTextController.text.isEmpty
            ? allCharacter!.length
            : searchedForCharacters!.length,
        itemBuilder: (context, index) {
          //TODO: not completed
          return CharacterItem(
            character: searchTextController.text.isEmpty
                ? allCharacter![index]
                : searchedForCharacters![index],
          );
        });
  }

  Widget _buildAppBarTitle() {
    return const Text('Characters', style: TextStyle(color: ThemeColor.gray));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.yellow,
        leading: isSearching
            ? const BackButton(
                color: ThemeColor.gray,
              )
            : Container(),
        title: isSearching ? _buildSearchField() : _buildAppBarTitle(),
      ),
      body: buildBlocWidget(),
    );
  }
}
