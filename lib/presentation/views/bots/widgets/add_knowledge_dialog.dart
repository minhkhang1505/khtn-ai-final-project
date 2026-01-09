import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/get_knowledges_usecase.dart';

class AddKnowledgeDialog extends StatefulWidget {
  final List<String> excludeKnowledgeIds;

  const AddKnowledgeDialog({
    super.key,
    this.excludeKnowledgeIds = const [],
  });

  @override
  State<AddKnowledgeDialog> createState() => _AddKnowledgeDialogState();
}

class _AddKnowledgeDialogState extends State<AddKnowledgeDialog> {
  List<KnowledgeResDto> _knowledges = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedKnowledgeId;

  @override
  void initState() {
    super.initState();
    _loadKnowledges();
  }

  Future<void> _loadKnowledges() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final useCase = context.read<GetKnowledgesUsecase>();
      final query = KnowledgeQuery(
        limit: 100,
        offset: 0,
        order: KnowledgeOrder.DESC,
        orderField: 'createdAt',
      );

      final response = await useCase.call(query);

      // Filter out knowledges that are already added to the bot
      final filteredKnowledges = response.data.where((k) {
        return !widget.excludeKnowledgeIds.contains(k.id);
      }).toList();

      setState(() {
        _knowledges = filteredKnowledges;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 700,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.library_add_outlined,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Add Knowledge to Bot',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: colorScheme.outlineVariant),

            // Content
            Expanded(
              child: _buildContent(colorScheme),
            ),

            // Actions
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _selectedKnowledgeId != null
                        ? () {
                            Navigator.of(context).pop(_selectedKnowledgeId);
                          }
                        : null,
                    child: const Text('Add Knowledge'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ColorScheme colorScheme) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load knowledge',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.error,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _loadKnowledges,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_knowledges.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.library_books_outlined,
                size: 64,
                color: colorScheme.onSurfaceVariant.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No Knowledge Available',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'All your knowledge bases are already added to this bot\nor you have no knowledge bases yet.',
                textAlign: TextAlign.center,
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _knowledges.length,
      itemBuilder: (context, index) {
        final knowledge = _knowledges[index];
        final isSelected = _selectedKnowledgeId == knowledge.id;

        return InkWell(
          onTap: () {
            setState(() {
              _selectedKnowledgeId = knowledge.id;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
              color: isSelected
                  ? colorScheme.primaryContainer.withOpacity(0.1)
                  : colorScheme.surfaceContainerLow,
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.library_books,
                    size: 24,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        knowledge.knowledgeName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        knowledge.description.isNotEmpty
                            ? knowledge.description
                            : 'No description',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Selection indicator
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: colorScheme.onPrimary,
                    ),
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.outlineVariant,
                        width: 2,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
