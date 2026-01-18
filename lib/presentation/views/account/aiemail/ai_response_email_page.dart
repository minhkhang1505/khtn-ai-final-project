import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/domain/entities/email_response_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_response_entity.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/error_dialog_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/aiemail/ai_email_viewmodel.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_tab_bar.dart';
import 'package:khtn_ai_final_project/presentation/views/account/aiemail/widgets/ai_response_email_tab.dart';
import 'package:khtn_ai_final_project/presentation/views/account/aiemail/widgets/ai_suggest_reply_tab.dart';

class AIResponseEmailPage extends StatefulWidget {
  const AIResponseEmailPage({super.key});

  @override
  State<AIResponseEmailPage> createState() => _AIResponseEmailPageState();
}

enum _AiEmailAction { response, suggest }

class _AIResponseEmailPageState extends State<AIResponseEmailPage>
    with SingleTickerProviderStateMixin {
  final _aiEmailViewModel = sl<AiEmailViewmodel>();

  static const EmailResponseEntity _mockResponse = EmailResponseEntity(
    email:
        'Kính gửi Trung tâm Hỗ trợ Sinh viên Trường ĐH Khoa học Tự nhiên, ĐHQG-HCM,\n\n'
        'Xin cảm ơn thông tin về "Ngày hội Sinh viên và Doanh nghiệp - Năm 2024". '
        'Tôi sẽ đăng ký tham gia sớm.\n\n'
        'Chúc các bạn một ngày tốt lành!\n\n'
        'Trân trọng,  \n',
    remainingUsage: 48,
  );

  static const List<String> _mockReplyIdeas = [
    'Cảm ơn bạn đã chia sẻ thông tin. Mình sẽ đăng ký tham gia sớm.',
    'Mình rất quan tâm đến sự kiện này và sẽ sắp xếp tham gia.',
    'Xin cảm ơn, mình sẽ phản hồi lại sau khi hoàn tất đăng ký.',
  ];

  late final TabController _tabController;
  _AiEmailAction _lastAction = _AiEmailAction.response;

  @override
  void initState() {
    super.initState();
    _aiEmailViewModel.addListener(_handleViewModelChange);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _aiEmailViewModel.removeListener(_handleViewModelChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleViewModelChange() {
    // Call setState to trigger rebuild when state changes
    // Schedule it for the next frame to avoid issues with synchronous calls
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }

    if (_aiEmailViewModel.state == AiEmailState.success) {
      if (_lastAction == _AiEmailAction.response) {
        _showResponseDialog(
          _aiEmailViewModel.response,
          title: 'Email Generated Successfully',
        );
      } else {
        _showSuggestIdeasDialog(_aiEmailViewModel.suggestReplyIdeaResponse);
      }
    } else if (_aiEmailViewModel.state == AiEmailState.failure) {
      if (_lastAction == _AiEmailAction.response) {
        _showResponseDialog(
          _mockResponse,
          title: 'Mock Email (Fallback)',
          isMock: true,
          errorMessage: _aiEmailViewModel.errorMessage,
        );
      } else {
        _showSuggestIdeasDialog(
          _aiEmailViewModel.suggestReplyIdeaResponse,
          isMock: true,
          errorMessage: _aiEmailViewModel.errorMessage,
        );
      }
    }
  }

  void _showResponseDialog(
    EmailResponseEntity? response, {
    required String title,
    bool isMock = false,
    String? errorMessage,
  }) {
    if (response == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isMock ? Icons.warning_amber_rounded : Icons.check_circle,
              color: isMock
                  ? Colors.orange
                  : Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMock)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: AppBorderRadius.small,
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorMessage == null || errorMessage.isEmpty
                              ? 'Showing a mock email due to a temporary error.'
                              : 'Mock email shown. Error: $errorMessage',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              if (isMock) const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: AppBorderRadius.medium,
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Generated Email:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 18),
                          onPressed: () {
                            final data = ClipboardData(text: response.email);
                            Clipboard.setData(data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Email copied to clipboard'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          tooltip: 'Copy email',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      response.email,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: AppBorderRadius.small,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Remaining usage: ${response.remainingUsage}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = _aiEmailViewModel.state == AiEmailState.loading;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: const Text('AI Email Response'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              CustomTabbar(
                controller: _tabController,
                tabLabels: const ['Response Email', 'Suggest Reply'],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AiResponseEmailTab(
                      viewModel: _aiEmailViewModel,
                      isLoading: isLoading,
                      onSubmitStart: () {
                        _lastAction = _AiEmailAction.response;
                      },
                    ),
                    AiSuggestReplyTab(
                      viewModel: _aiEmailViewModel,
                      isLoading: isLoading,
                      onSubmitStart: () {
                        _lastAction = _AiEmailAction.suggest;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: Card(
                  margin: const EdgeInsets.all(32),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LoadingIndicatorWidget(),
                        const SizedBox(height: 16),
                        Text(
                          'Generating email response...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Please wait while AI creates your email',
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showSuggestIdeasDialog(
    SuggestReplyIdeaResponseEntity? response, {
    bool isMock = false,
    String? errorMessage,
  }) {
    final ideas = (response?.ideas.isNotEmpty ?? false)
        ? response!.ideas
        : _mockReplyIdeas;

    if (ideas.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 12),
            const Expanded(child: Text('Reply Ideas Generated')),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMock)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: AppBorderRadius.small,
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorMessage == null || errorMessage.isEmpty
                              ? 'Showing mock ideas due to a temporary error.'
                              : 'Mock ideas shown. Error: $errorMessage',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              if (isMock) const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ideas.map((idea) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                      borderRadius: AppBorderRadius.medium,
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withOpacity(0.4),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SelectableText(
                            idea,
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 18),
                          onPressed: () {
                            final data = ClipboardData(text: idea);
                            Clipboard.setData(data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Idea copied to clipboard'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          tooltip: 'Copy idea',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
