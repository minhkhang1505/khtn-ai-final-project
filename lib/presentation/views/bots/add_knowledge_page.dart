import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/edit_bot_view_model.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';

class AddKnowledgePage extends StatefulWidget {
  final List<String> excludeKnowledgeIds;
  final EditBotViewModel viewModel;

  const AddKnowledgePage({
    super.key,
    this.excludeKnowledgeIds = const [],
    required this.viewModel,
  });

  @override
  State<AddKnowledgePage> createState() => _AddKnowledgePageState();
}

class _AddKnowledgePageState extends State<AddKnowledgePage> {
  List<KnowledgeEntity> _knowledges = [];
  List<KnowledgeEntity> _filteredKnowledges = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  final Set<String> _selectedKnowledgeIds = {};

  @override
  void initState() {
    super.initState();
    _loadKnowledges();
  }

  void _filterKnowledges(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredKnowledges = _knowledges
          .where((k) =>
              k.knowledgeName.toLowerCase().contains(_searchQuery) ||
              k.description.toLowerCase().contains(_searchQuery))
          .toList();
    });
  }

  Future<void> _loadKnowledges() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await widget.viewModel.getUserKnowledges();
      final data = widget.viewModel.userKnowledges;
      setState(() {
        _knowledges = data;
        _filteredKnowledges = data;
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Knowledge to Bot'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: ResponsiveHelper.chatContentWidth(context),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: _filterKnowledges,
                  decoration: InputDecoration(
                    hintText: 'Search knowledge...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),

              // Content
              Expanded(
                child: _buildContent(colorScheme),
              ),

              // Action button
              if (_selectedKnowledgeIds.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(_selectedKnowledgeIds.toList());
                    },
                    child: Text('Add ${_selectedKnowledgeIds.length} Knowledge'),
                  ),
                ),
            ],
          ),
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

    if (_filteredKnowledges.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.library_books_outlined,
                size: 64,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 80),
              ),
              const SizedBox(height: 16),
              Text(
                _searchQuery.isNotEmpty ? 'No results found' : 'No Knowledge Available',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredKnowledges.length,
      itemBuilder: (context, index) {
        final knowledge = _filteredKnowledges[index];
        final isAdded = widget.excludeKnowledgeIds.contains(knowledge.id);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: isAdded ? null : () {
              setState(() {
                if (_selectedKnowledgeIds.contains(knowledge.id)) {
                  _selectedKnowledgeIds.remove(knowledge.id);
                } else {
                  _selectedKnowledgeIds.add(knowledge.id);
                }
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isAdded
                      ? colorScheme.outlineVariant.withValues(alpha: 80)
                      : (_selectedKnowledgeIds.contains(knowledge.id)
                          ? colorScheme.primary
                          : colorScheme.outlineVariant),
                  width: isAdded ? 1 : (_selectedKnowledgeIds.contains(knowledge.id) ? 2 : 1),
                ),
                borderRadius: BorderRadius.circular(12),
                color: isAdded
                    ? colorScheme.surfaceContainerLow.withValues(alpha: 80)
                    : (_selectedKnowledgeIds.contains(knowledge.id)
                        ? colorScheme.primaryContainer.withValues(alpha: 30)
                        : colorScheme.surfaceContainerLow),
              ),
              child: Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 80),
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
                  // Badge for added or selected items
                  if (isAdded)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Added',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                    )
                  else if (_selectedKnowledgeIds.contains(knowledge.id))
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
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
