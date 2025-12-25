import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_tab_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt/prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_view_model.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompt_item.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:provider/provider.dart';

class ShowPromptModalBottomSheet extends StatelessWidget {
  const ShowPromptModalBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => sl<PromptViewmodel>()..getAllPrompts(),
          child: const _PromptModalContent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _PromptModalContent extends StatefulWidget {
  const _PromptModalContent();

  @override
  State<_PromptModalContent> createState() => _PromptModalContentState();
}

class _PromptModalContentState extends State<_PromptModalContent>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PromptViewmodel>();
    final prompts = viewModel.prompts ?? [];
    final privatePrompts = viewModel.privatePrompts ?? [];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
              child: Text(
                "Prompts",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            CustomTabbar(
              controller: _tabController,
              tabLabels: const ['Public', 'Private'],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPromptList(prompts, viewModel),
                  _buildPromptList(privatePrompts, viewModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptList(
    List<PromptEntity> prompts,
    PromptViewmodel viewModel,
  ) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: prompts.length + 1,
        itemBuilder: (context, index) {
          if (index == prompts.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: switch (viewModel.loadMoreState) {
                  LoadMoreState.loading => const CircularProgressIndicator(),
                  LoadMoreState.noMoreData => const Text(
                    "No more prompts to load.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  LoadMoreState.idle => const SizedBox.shrink(),
                },
              ),
            );
          }
          final prompt = prompts[index];
          return PromptItem(
            onTap: () => _handleItemTap(context, prompt),
            prompt: prompt,
            onFavoriteTap: () {
              // Handle favorite toggle
            },
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final viewModel = context.read<PromptViewmodel>();

      if (viewModel.loadMoreState == LoadMoreState.idle && viewModel.hasNext) {
        debugPrint(
          'ShowPromptModalBottomSheet: Reached bottom, loading more prompts...',
        );
        viewModel.loadMorePrompts();
      }
    }
  }

  Future<void> _onRefresh() async {
    final viewModel = context.read<PromptViewmodel>();
    await viewModel.refreshPrompts();
  }

  void _handleItemTap(BuildContext context, PromptEntity prompt) {
    // get the content of the prompt and send it as a message, put it in the chat input box
    final chatViewModel = context.read<ChatViewModel>();
    chatViewModel.setInputMessage(prompt.content);
    Navigator.pop(context);
  }
}
