import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class FileInputSection extends StatefulWidget {
  final void Function(PlatformFile?)? onFilePicked;
  const FileInputSection({super.key, this.onFilePicked});

  @override
  State<FileInputSection> createState() => _FileInputSectionState();
}

class _FileInputSectionState extends State<FileInputSection> {
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() => _selectedFile = file);
      widget.onFilePicked?.call(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(150),
          width: 1.5,
        ),
        borderRadius: AppBorderRadius.extraLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "File Input Section",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.medium,
                side: BorderSide(
                  color: colorScheme.outline.withAlpha(100),
                  width: 1,
                ),
              ),
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () {
              _pickFile();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_file.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text("Select File"),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_selectedFile != null)
            Column(
              children: [
                const Divider(),
                Text(
                  'Selected File: ${_selectedFile!.name}',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'Size: ${(_selectedFile!.size / 1024).toStringAsFixed(2)} KB',
                  style: TextStyle(color: colorScheme.onSurface.withAlpha(140)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
