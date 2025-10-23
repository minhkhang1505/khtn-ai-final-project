class Language {
  final String code;
  final String name;

  const Language({required this.code, required this.name});
}

const List<Language> languages = [
  Language(code: 'en', name: 'English'),
  Language(code: 'es', name: 'Spanish'),
  Language(code: 'fr', name: 'French'),
  Language(code: 'de', name: 'German'),
  Language(code: 'vi', name: 'Vietnamese'),
];
