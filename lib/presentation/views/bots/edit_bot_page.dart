import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/edit_bot_view_model.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/save_action_button_row.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/loading_widget.dart';
import 'widgets/ai_model_card.dart';
import 'widgets/edit_bot_app_bar.dart';
import 'widgets/knowledge_base_card.dart';
import 'widgets/bot_information_card.dart';
import 'widgets/bot_action_card.dart';
import 'add_knowledge_page.dart';

/// Edit Bot Page - Configure AI bot settings
class EditBotPage extends StatefulWidget {
  final BotModel bot;
  const EditBotPage({super.key, required this.bot});

  @override
  State<EditBotPage> createState() => _EditBotPageState();
}

class _EditBotPageState extends State<EditBotPage> {
  final Set<int> selectedIndices = {};

  @override
  void initState() {
    super.initState();
    // Defer setup to after first frame to avoid notifying during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final editBotViewModel = context.read<EditBotViewModel>();
      await editBotViewModel.setupBot(widget.bot);
    });
  }

  @override
  Widget build(BuildContext context) {
    final editBotViewModel = context.watch<EditBotViewModel>();

    return Scaffold(
      appBar: EditBotAppBar(
        bot: widget.bot,
        onBackPressed: () {
          Navigator.of(context).pop();
          editBotViewModel.clearForm();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.chatContentWidth(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (editBotViewModel.isDataLoading)
                    const LoadingIndicatorWidget(),
                  if (!editBotViewModel.isDataLoading) ...[
                    // Status & Actions Section
                    BotActionCard(
                      bot: widget.bot,
                      isFavoriteNotifier: editBotViewModel.isFavoriteNotifier,
                      onFavoriteToggle: () async {
                        await editBotViewModel.toggleFavorite();
                      },
                      onCanceled: () {
                        editBotViewModel.clearForm();
                        Navigator.pop(context);
                      },
                      onDeleted: () async {
                        final pageContext = context;
                        await showDialog<void>(
                          context: pageContext,
                          barrierDismissible: false,
                          builder: (dialogContext) {
                            bool? success;
                            String? resultMessage;

                            return StatefulBuilder(
                              builder: (context, setState) {
                                Widget content;
                                List<Widget> actions;

                                if (editBotViewModel.isLoading) {
                                  content = Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text('Deleting...'),
                                    ],
                                  );
                                  actions = [
                                    TextButton(
                                      onPressed: null,
                                      child: const Text('Cancel'),
                                    ),
                                  ];
                                } else if (success != null) {
                                  content = Text(
                                    resultMessage ??
                                        (success == true
                                            ? 'Bot deleted successfully'
                                            : 'Failed to delete bot'),
                                  );
                                  actions = [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext);
                                        if (success == true) {
                                          Navigator.pop(pageContext, {
                                            'deleted': true,
                                            'message':
                                                resultMessage ??
                                                'Bot deleted successfully',
                                          });
                                        }
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ];
                                } else {
                                  content = const Text(
                                    'Are you sure you want to delete this bot? This action cannot be undone.',
                                  );
                                  actions = [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        final vm = pageContext
                                            .read<EditBotViewModel>();
                                        final ok = await vm.deleteBot();
                                        final errorMsg = vm.errorMessage;
                                        setState(() {
                                          success = ok;
                                          resultMessage = ok
                                              ? 'Bot deleted successfully'
                                              : (errorMsg ??
                                                    'Failed to delete bot');
                                        });
                                      },
                                      icon: const Icon(Icons.delete_outline),
                                      label: const Text('Delete'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                        foregroundColor: Theme.of(
                                          context,
                                        ).colorScheme.onError,
                                      ),
                                    ),
                                  ];
                                }

                                return AlertDialog(
                                  title: const Text('Delete Bot'),
                                  content: content,
                                  actions: actions,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.cardSpacing),

                    // Basic Information Section
                    BotInformationCard(
                      assistantNameController:
                          editBotViewModel.assistantNameController,
                      assistantNameError: editBotViewModel.assistantNameError,
                      instructionsController:
                          editBotViewModel.instructionsController,
                      descriptionController:
                          editBotViewModel.descriptionController,
                    ),
                    const SizedBox(height: AppSpacing.cardSpacing),

                    // Knowledge Base Section
                    KnowledgeBaseCard(
                      knowledges: editBotViewModel.knowledges,
                      isLoading: editBotViewModel.isKnowledgeLoading,
                      onAddKnowledge: () async {
                        final selectedKnowledgeIds = await Navigator.of(context).push<List<String>>(
                          MaterialPageRoute(
                            builder: (context) => AddKnowledgePage(
                              excludeKnowledgeIds: editBotViewModel.knowledges.map((k) => k.id).toList(),
                              viewModel: editBotViewModel,
                            ),
                          ),
                        );

                        if (selectedKnowledgeIds != null &&
                            selectedKnowledgeIds.isNotEmpty &&
                            mounted) {
                          final scaffold = ScaffoldMessenger.of(context);

                          // Add all selected knowledge bases
                          for (final knowledgeId in selectedKnowledgeIds) {
                            final success = await editBotViewModel
                                .addKnowledgeToBot(knowledgeId);

                            if (!success) {
                              scaffold.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    editBotViewModel.errorMessage ??
                                        'Failed to add knowledge',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                          }

                          scaffold.showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added ${selectedKnowledgeIds.length} knowledge base(s) successfully',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.cardSpacing),

                    // AI model Section
                    AiModelCard(
                      errorText: null,
                      isReadOnly: true,
                      fixedModelId: widget.bot.model?.id,
                    ),
                    const SizedBox(height: AppSpacing.cardSpacing),
                    // Action Buttons
                    SaveActionButtonRow(
                      onLeftButtonPress: () {
                        editBotViewModel.clearForm();
                        Navigator.pop(context);
                      },
                      onRightButtonPress: () async {
                        final pageContext = context;
                        await showDialog<void>(
                          context: pageContext,
                          barrierDismissible: false,
                          builder: (dialogContext) {
                            bool? success;
                            String? resultMessage;

                            return StatefulBuilder(
                              builder: (context, setState) {
                                Widget content;
                                List<Widget> actions;

                                if (editBotViewModel.isLoading) {
                                  content = Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text('Updating bot...'),
                                    ],
                                  );
                                  actions = [
                                    TextButton(
                                      onPressed: null,
                                      child: const Text('Cancel'),
                                    ),
                                  ];
                                } else if (success != null) {
                                  content = Text(
                                    resultMessage ??
                                        (success == true
                                            ? 'Bot updated successfully'
                                            : 'Failed to update bot'),
                                  );
                                  actions = [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext);
                                        if (success == true) {
                                          Navigator.pop(pageContext);
                                        }
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ];
                                } else {
                                  // Start updating
                                  Future.microtask(() async {
                                    final ok = await editBotViewModel
                                        .updateBot();
                                    setState(() {
                                      success = ok;
                                      resultMessage = ok
                                          ? 'Bot updated successfully'
                                          : (editBotViewModel.errorMessage ??
                                                'Failed to update bot');
                                    });
                                  });
                                  content = Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text('Updating bot...'),
                                    ],
                                  );
                                  actions = [
                                    TextButton(
                                      onPressed: null,
                                      child: const Text('Cancel'),
                                    ),
                                  ];
                                }

                                return AlertDialog(
                                  title: const Text('Update Bot'),
                                  content: content,
                                  actions: actions,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
