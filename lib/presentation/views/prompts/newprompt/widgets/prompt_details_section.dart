import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/core/constants/categories.dart';
import 'package:khtn_ai_final_project/core/constants/languages.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_text_field.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_dropdown_field.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/section_header.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/public_prompt_switch.dart';

class PromptDetailsSection extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController contentController;
  final String? selectedCategory;
  final String? selectedLanguage;
  final bool isPublic;
  final ValueChanged<String?>? onCategoryChanged;
  final ValueChanged<String?>? onLanguageChanged;
  final ValueChanged<bool> onPublicChanged;

  const PromptDetailsSection({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.contentController,
    this.selectedCategory,
    this.selectedLanguage,
    required this.isPublic,
    this.onCategoryChanged,
    this.onLanguageChanged,
    required this.onPublicChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.extraLarge,
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withAlpha(150),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: "Prompt Details",
            subtitle: "Create a prompt template for AI interaction",
          ),
          const SizedBox(height: 16),
          PromptTextField(
            label: "Title",
            hintText: "e.g., Professional Email Writer",
            controller: titleController,
          ),
          const SizedBox(height: 16),
          PromptTextField(
            label: "Description",
            hintText: "Short description for this prompt",
            controller: descriptionController,
          ),
          const SizedBox(height: 16),
          PromptTextField(
            label: "Content",
            hintText:
                "Write your prompt here... use {variable} for dynamic part like {topic} or {recipient}",
            maxLines: 5,
            controller: contentController,
          ),
          const SizedBox(height: 16),
          if (selectedCategory == null)
            CircularProgressIndicator()
          else
            Row(
              children: [
                Expanded(
                  child: PromptDropdownField<String>(
                    label: "Category",
                    initialSelection: selectedCategory,
                    onSelected: onCategoryChanged,
                    entries: categories
                        .map(
                          (category) => DropdownMenuEntry(
                            value: category.id.name,
                            label: category.name,
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PromptDropdownField<String>(
                    label: "Language",
                    initialSelection: selectedLanguage,
                    onSelected: onLanguageChanged,
                    entries: languages
                        .map(
                          (language) => DropdownMenuEntry(
                            value: language.code,
                            label: language.name,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          PublicPromptSwitch(isPublic: isPublic, onChanged: onPublicChanged),
        ],
      ),
    );
  }
}
