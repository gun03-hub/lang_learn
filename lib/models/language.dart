class Language {
  final String name;
  final String code;
  final String flag;
  final String description;  // Added description field

  Language({
    required this.name, 
    required this.code, 
    required this.flag, 
    required this.description,
  });
}

final List<Language> languages = [
  Language(
    name: 'Spanish', 
    code: 'es', 
    flag: '🇪🇸',
    description: 'Learn one of the world\'s most spoken languages',
  ),
  Language(
    name: 'French', 
    code: 'fr', 
    flag: '🇫🇷',
    description: 'Master the language of love and culture',
  ),
  Language(
    name: 'Japanese', 
    code: 'ja', 
    flag: '🇯🇵',
    description: 'Explore the fascinating language of Japan',
  ),
  Language(
    name: 'German', 
    code: 'de', 
    flag: '🇩🇪',
    description: 'Learn the language of innovation',
  ),
  Language(
    name: 'Italian', 
    code: 'it', 
    flag: '🇮🇹',
    description: 'Discover the language of art and cuisine',
  ),
  Language(
    name: 'Korean', 
    code: 'ko', 
    flag: '🇰🇷',
    description: 'Experience the language of K-culture',
  ),
];