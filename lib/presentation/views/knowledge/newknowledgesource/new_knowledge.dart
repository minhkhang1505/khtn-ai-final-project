import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class NewKnowledgeScreen extends StatefulWidget {
  const NewKnowledgeScreen({super.key});

  @override
  State<NewKnowledgeScreen> createState() => _NewKnowledgeScreenState();
}

class _NewKnowledgeScreenState extends State<NewKnowledgeScreen> {
  final TextEditingController _knowledgeNameController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Knowledge'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: AppBorderRadius.extraLarge,
                  color: colorScheme.surfaceContainerLow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Add Data Source",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    //dropdown menu for selecting knowledge source type
                    Row(
                      children: [
                        Text(
                          'Source: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        DropdownMenu<KnowledgeSourceType>(
                          controller: _knowledgeNameController,
                          enableFilter: true,
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 1.5,
                              ),
                            ),
                          ),
                          initialSelection: knowledgeSources[0],
                          requestFocusOnTap: true,
                          onSelected: (KnowledgeSourceType? source) {
                            setState(() {
                              _knowledgeNameController.text =
                                  source?.name ?? '';
                            });
                          },
                          dropdownMenuEntries: knowledgeSources.map((source) {
                            return DropdownMenuEntry<KnowledgeSourceType>(
                              value: source,
                              label: source.name,
                              leadingIcon: SvgPicture.asset(
                                source.iconAssetPath,
                                width: 24,
                                height: 24,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    // enter knowledge name
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Source Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'e.g., Company Documents',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Source Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Describe the knowledge source...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          minLines: 4,
                          maxLines: null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'URL or Path',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'e.g., https://www.example.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // enter knowledge description
                    // input field for knowledge source (URL, file upload, text input)
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppBorderRadius.medium,
                      ),
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(color: colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KnowledgeSourceType {
  final String iconAssetPath;
  final String name;

  const KnowledgeSourceType({required this.iconAssetPath, required this.name});
}

final List<KnowledgeSourceType> knowledgeSources = [
  KnowledgeSourceType(
    iconAssetPath: 'assets/icons/ic_slack.svg',
    name: 'Slack',
  ),
  KnowledgeSourceType(
    iconAssetPath: 'assets/icons/ic_drive.svg',
    name: 'Drive',
  ),
  KnowledgeSourceType(
    iconAssetPath: 'assets/icons/ic_confluence.svg',
    name: 'Confluence',
  ),
  KnowledgeSourceType(iconAssetPath: 'assets/icons/ic_url.svg', name: 'URL'),
];
