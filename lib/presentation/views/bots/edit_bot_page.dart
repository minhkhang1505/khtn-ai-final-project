import 'package:flutter/material.dart' hide SearchBar;
import 'package:khtn_ai_final_project/core/constants/constants.dart' show AppBarInfo;
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/category_option_menu.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/ai_model_option_menu.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';

class EditBotPage extends StatefulWidget {
  const EditBotPage({super.key});

  @override
  State<EditBotPage> createState() => _EditBotPageState();
}

class _EditBotPageState extends State<EditBotPage> {
  final Set<int> selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        toolbarHeight: AppBarInfo.height,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Bot',
                  style: AppBarInfo.titleTextStyle,
                ),

                SizedBox(height: 4),
                
                Text(
                  'Set up your AI assistant bot',
                  style: AppBarInfo.subtitleTextStyle,
                ),
              ],
            ),
          ],
        ),
      centerTitle: false,
      actions: const [
        Padding(
            padding: EdgeInsets.only(right: 16),
            child: Chip(
              label: Text(
                'Active',
                style: TextStyle(color: Colors.green),
              ),
              backgroundColor: Color(0xFFE8F5E9),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.contentWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Basic Information Section
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  margin: const EdgeInsets.all(0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'Basic Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Name and describe your bot',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Bot Name label
                        const Text(
                          'Bot Name *',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Bot Name input
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'e.g., Customer Support Assistant',
                            hintStyle: const TextStyle(color: Colors.black45),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: AppBorderRadius.medium,
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Description label
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Description input
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'What does this bot do?',
                            hintStyle: const TextStyle(color: Colors.black45),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: AppBorderRadius.medium,
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 16),

                        // Category label and AI model
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Category *',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  CategoryOptionMenu(
                                    onChanged: (category) {
                                      // Handle category change if needed
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            // AI Model dropdown
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'AI Model *',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  AiModelOptionMenu(
                                    onChanged: (model) {
                                      // Handle model change if needed
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                // Workflows Section
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  margin: const EdgeInsets.all(0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'System Prompts',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),

                        const Text(
                          "Define your bot's personality and behavior",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // System Prompt TextField
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'e.g., You are a helpful customer support assistant.',
                            hintStyle: const TextStyle(color: Colors.black45),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: AppBorderRadius.medium,
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),

                // Knowledge Base Section
                const SizedBox(height: 12),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  margin: const EdgeInsets.all(0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        const Text(
                          'Knowledge Base',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),

                        const Text(
                          "Enhance your bot’s intelligence by adding relevant knowledge sources.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Upload Button
                        SizedBox(
                          width: double.infinity, // chiếm full chiều ngang của card
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Handle file upload
                            },
                            icon: const Icon(Icons.upload_file),
                            label: const Text('Upload Documents'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppBorderRadius.small,
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.medium,
                          ),
                          side: BorderSide(color: Theme.of(context).primaryColor),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.medium,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}