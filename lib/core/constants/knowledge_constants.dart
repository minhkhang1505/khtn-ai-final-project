/// Constants for knowledge-related screens
class KnowledgeConstants {
  // Screen titles
  static const String newKnowledgeTitle = 'New Knowledge';
  static const String editKnowledgeTitle = 'Edit Knowledge';

  // Section titles
  static const String addDataSourceTitle = 'Add Data Source';

  // Field labels
  static const String sourceLabel = 'Source:';
  static const String sourceNameLabel = 'Source Name';
  static const String sourceDescriptionLabel = 'Source Description';
  static const String urlOrPathLabel = 'URL or Path';

  // Hints
  static const String sourceNameHint = 'e.g., Company Documents';
  static const String sourceDescriptionHint =
      'Describe the knowledge source...';
  static const String urlOrPathHint = 'e.g., https://www.example.com';

  // Button labels
  static const String saveButton = 'Save';
  static const String editButton = 'Edit';

  // Validation messages
  static const String sourceNameRequired = 'Please enter a source name';
  static const String urlRequired = 'Please enter a URL or path';
  static const String invalidUrl = 'Please enter a valid URL';
}
