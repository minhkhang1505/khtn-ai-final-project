/// Represents a type of knowledge source with its icon and name
class KnowledgeSourceType {
  final String iconAssetPath;
  final String name;

  const KnowledgeSourceType({required this.iconAssetPath, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KnowledgeSourceType &&
          runtimeType == other.runtimeType &&
          iconAssetPath == other.iconAssetPath &&
          name == other.name;

  @override
  int get hashCode => iconAssetPath.hashCode ^ name.hashCode;
}

/// Available knowledge source types
class KnowledgeSourceTypes {
  static const slack = KnowledgeSourceType(
    iconAssetPath: 'assets/icons/ic_slack.svg',
    name: 'Slack',
  );

  static const drive = KnowledgeSourceType(
    iconAssetPath: 'assets/icons/ic_drive.svg',
    name: 'Drive',
  );

  static const confluence = KnowledgeSourceType(
    iconAssetPath: 'assets/icons/ic_confluence.svg',
    name: 'Confluence',
  );

  static const url = KnowledgeSourceType(
    iconAssetPath: 'assets/icons/ic_url.svg',
    name: 'URL',
  );

  static const List<KnowledgeSourceType> all = [slack, drive, confluence, url];
}
