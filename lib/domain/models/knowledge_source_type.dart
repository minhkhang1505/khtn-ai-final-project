/// Represents a type of knowledge source with its icon and name
class DataSourceType {
  final String iconAssetPath;
  final String name;

  const DataSourceType({required this.iconAssetPath, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataSourceType &&
          runtimeType == other.runtimeType &&
          iconAssetPath == other.iconAssetPath &&
          name == other.name;

  @override
  int get hashCode => iconAssetPath.hashCode ^ name.hashCode;
}

/// Available knowledge source types
class DataSourceTypes {
  static const slack = DataSourceType(
    iconAssetPath: 'assets/icons/ic_slack.svg',
    name: 'Slack',
  );

  static const drive = DataSourceType(
    iconAssetPath: 'assets/icons/ic_drive.svg',
    name: 'Drive',
  );

  static const confluence = DataSourceType(
    iconAssetPath: 'assets/icons/ic_confluence.svg',
    name: 'Confluence',
  );

  static const url = DataSourceType(
    iconAssetPath: 'assets/icons/ic_url.svg',
    name: 'URL',
  );

  static const file = DataSourceType(
    iconAssetPath: 'assets/icons/ic_file.svg',
    name: 'File',
  );

  static const List<DataSourceType> all = [slack, drive, confluence, url, file];
}
