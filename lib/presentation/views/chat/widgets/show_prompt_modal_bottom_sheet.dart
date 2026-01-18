import 'dart:async';

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
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_onScroll);
    _tabController.addListener(_onTabChanged);

    // Load initial data for Public tab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<PromptViewmodel>();
      if (viewModel.prompts == null || viewModel.prompts!.isEmpty) {
        viewModel.getAllPrompts(query: _searchController.text);
      }
    });
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;

    final viewModel = context.read<PromptViewmodel>();
    if (_tabController.index == 0) {
      // Public tab
      if (viewModel.prompts == null || viewModel.prompts!.isEmpty) {
        viewModel.getAllPrompts(query: _searchController.text);
      }
    } else {
      // Private tab
      if (viewModel.privatePrompts == null ||
          viewModel.privatePrompts!.isEmpty) {
        viewModel.getPrivatePrompts(query: _searchController.text);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchDebounce?.cancel();
    _searchController.dispose();
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
              child: Text(
                "Prompts",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildSearchField(context),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTabbar(
                    controller: _tabController,
                    tabLabels: const ['Public', 'Private'],
                  ),
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
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      '/prompts',
                    );
                    // If result is prompt content, close modal and set it
                    if (result is String && result.isNotEmpty) {
                      if (context.mounted) {
                        Navigator.pop(context); // Close modal
                        widget.chatViewModel.setInputMessage(result);
                      }
                    }
                  },
                  label: Text(
                    "Categories",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPromptList(prompts, viewModel, isPrivate: false),
                  _buildPromptList(privatePrompts, viewModel, isPrivate: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: _searchController,
      onChanged: _onSearchChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search by title or description',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                  _triggerSearch('');
                },
              )
            : null,
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh.withAlpha(120),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 0, // Giảm chiều cao từ 10 xuống 4
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _onSearchChanged(String value) {
    setState(() {});
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _triggerSearch(value);
    });
  }

  void _triggerSearch(String value) {
    final viewModel = context.read<PromptViewmodel>();
    if (_tabController.index == 0) {
      viewModel.getAllPrompts(query: value);
    } else {
      viewModel.getPrivatePrompts(query: value);
    }
  }

  Widget _buildPromptList(
    List<PromptEntity> prompts,
    PromptViewmodel viewModel, {
    required bool isPrivate,
  }) {
    final loadMoreState = isPrivate
        ? viewModel.privateLoadMoreState
        : viewModel.allLoadMoreState;
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
                child: switch (loadMoreState) {
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
      final isPrivateTab = _tabController.index == 1;
      final loadMoreState = isPrivateTab
          ? viewModel.privateLoadMoreState
          : viewModel.allLoadMoreState;
      final hasNext = isPrivateTab
          ? viewModel.privateHasNext
          : viewModel.allHasNext;

      if (loadMoreState == LoadMoreState.idle && hasNext) {
        debugPrint(
          'ShowPromptModalBottomSheet: Reached bottom, loading more prompts...',
        );
        if (isPrivateTab) {
          viewModel.loadMorePrivatePrompts();
        } else {
          viewModel.loadMorePrompts();
        }
      }
    }
  }

  Future<void> _onRefresh() async {
    final viewModel = context.read<PromptViewmodel>();
    if (_tabController.index == 0) {
      await viewModel.getAllPrompts(query: _searchController.text);
    } else {
      await viewModel.getPrivatePrompts(query: _searchController.text);
    }
  }

  void _handleItemTap(BuildContext context, PromptEntity prompt) {
    // get the content of the prompt and send it as a message, put it in the chat input box
    widget.chatViewModel.setInputMessage(prompt.content);
    Navigator.pop(context);
  }
}
