import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../models/characters.dart';
import '../services/character_services.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import 'character_detail_screen.dart';




class CharactersScreen extends StatelessWidget {
  final CharacterService charactersService = CharacterService();

  CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.charactersScreenTitle),
        backgroundColor: AppColors.primaryColor,
      ),
      body: FutureBuilder<List<Character>>(
        future: charactersService.fetchCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingScreen(screenSize);
          } else if (snapshot.hasError) {
            return const Center(child: Text(AppStrings.charactersError));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text(AppStrings.noCharactersFound));
          } else {
            final characters = snapshot.data!;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return SizedBox(
                  height: screenSize.height * 0.10,
                  child: Card(
                    surfaceTintColor: AppColors.primaryColor,
                    elevation: 3,
                    child: ListTile(
                      leading: Hero(
                        tag: character.name,
                        child: ClipOval(
                          child: CachedNetworkImage(

                            imageUrl: character.image,
                            placeholder: (context, url) => SizedBox(
                              width: 50,
                              height: 80,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      title: Text(
                        character.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(character.actor),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetailScreen(
                              character: character,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildLoadingScreen(Size screenSize) {
    return ListView.builder(
      itemCount: 5, // Placeholder for shimmer effect
      itemBuilder: (context, index) {
        return SizedBox(
          height: screenSize.height * 0.10,
          child: Card(
            elevation: 3,
            child: ListTile(
              leading: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.white,
                ),
              ),
              title: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: screenSize.width * 0.5,
                  height: 20,
                  color: Colors.white,
                ),
              ),
              subtitle: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: screenSize.width * 0.3,
                  height: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// final charactersProvider = FutureProvider<List<Character>>((ref) async {
//   final service = ref.watch(charactersServiceProvider);
//   return service.fetchCharacters();
// });
//
// final charactersServiceProvider = Provider<CharacterService>((ref) {
//   return CharacterService();
// });
