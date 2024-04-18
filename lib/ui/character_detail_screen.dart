
import 'package:flutter/material.dart';
import 'package:harry_potter_characters/utils/app_colors.dart';

import '../models/characters.dart';
class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: AppColors.primaryColor,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontSize: 22
        ),
        title: Text(widget.character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: FadeTransition(
                opacity: _animation,
                child: Hero(
                  tag: widget.character.name,
                  child: CircleAvatar(
                    radius: 160,
                    backgroundImage: NetworkImage(widget.character.image),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Name', widget.character.name),
                  _buildDetailRow('Actor', widget.character.actor),
                  _buildDetailRow('House', widget.character.house),
                  _buildDetailRow('Date of Birth', widget.character.dateOfBirth ?? 'Unknown'),
                  _buildDetailRow('Alternate Names', widget.character.alternateNames.join(", ")),
                  _buildDetailRow('Species', widget.character.species),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(fontSize: 16.0,color: AppColors.lightTextColor ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
        ),
        Divider(
          thickness: 2,
          color: AppColors.lightTextColor.withOpacity(0.3),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
