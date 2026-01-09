import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    // Lấy ChatViewModel từ parent context trước khi mở modal
    final chatViewModel = context.read<ChatViewModel>();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        return ChangeNotifierProvider(
          create: (_) => sl<PromptViewmodel>()..getAllPrompts(),
          child: _PromptModalContent(chatViewModel: chatViewModel),
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
  final ChatViewModel chatViewModel;

  const _PromptModalContent({required this.chatViewModel});

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
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Prompts",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primaryContainer,
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/prompts');
                    },
                    label: Text(
                      "All",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/ic_all_prompts.svg',
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
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
    widget.chatViewModel.setInputMessage(prompt.content);
    Navigator.pop(context);
  }
}
