class Character {
  final String image;
  final String name;
  final String actor;
  final String house;
  final String? dateOfBirth;
  final List<String> alternateNames; // List of alternate names
  final String species;


  Character({
    required this.image,
    required this.name,
    required this.actor,
    required this.house,
    this.dateOfBirth,
    required this.alternateNames,
    required this.species,

  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      image: json["image"],
      name: json["name"],
      actor: json["actor"],
      house: json["house"],
      dateOfBirth: json["dateOfBirth"],
      alternateNames: List<String>.from(json["alternate_names"]),
      species: json["species"],
    );
  }
}
