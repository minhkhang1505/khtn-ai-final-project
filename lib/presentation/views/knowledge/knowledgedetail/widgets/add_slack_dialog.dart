import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/labeled_text_field.dart';

/// Dialog for adding a Slack data source
class AddSlackDialog extends StatefulWidget {
  const AddSlackDialog({super.key});

  @override
  State<AddSlackDialog> createState() => _AddSlackDialogState();
}

class _AddSlackDialogState extends State<AddSlackDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _botTokenController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureToken = true;

  @override
  void dispose() {
    _nameController.dispose();
    _botTokenController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Return the data
      Navigator.pop(context, {
        'name': _nameController.text.trim(),
        'botToken': _botTokenController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Slack',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name field
              LabeledTextField(
                label: 'Name',
                hintText: 'Enter a name for this data source',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Bot Token field
              const Text(
                'Slack Bot Token',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _botTokenController,
                obscureText: _obscureToken,
                decoration: InputDecoration(
                  hintText: 'xoxb-your-bot-token',
                  prefixIcon: const Icon(Icons.vpn_key),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureToken ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureToken = !_obscureToken;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your Slack bot token';
                  }
                  if (!value.trim().startsWith('xoxb-')) {
                    return 'Bot token should start with xoxb-';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Add'),
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
