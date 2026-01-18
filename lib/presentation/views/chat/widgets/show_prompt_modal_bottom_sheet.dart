import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/core/constants/categories.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/custom_tab_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt/prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_view_model.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/category_item.dart';
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
  CategoryType _selectedCategory = CategoryType.coding;
  String _selectedCategoryName = 'Coding';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_onScroll);
    _tabController.addListener(_onTabChanged);

    // Load initial data for Public tab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<PromptViewmodel>();
      if (viewModel.prompts == null || viewModel.prompts!.isEmpty) {
        viewModel.getAllPrompts(query: _searchController.text);
      }
      if (viewModel.categoryPrompts == null ||
          viewModel.categoryPrompts!.isEmpty) {
        viewModel.getPromptByCategory(
          _selectedCategory,
          query: _searchController.text,
        );
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
    } else if (_tabController.index == 1) {
      // Private tab
      if (viewModel.privatePrompts == null ||
          viewModel.privatePrompts!.isEmpty) {
        viewModel.getPrivatePrompts(query: _searchController.text);
      }
    } else if (_tabController.index == 2) {
      // Category tab
      if (viewModel.categoryPrompts == null ||
          viewModel.categoryPrompts!.isEmpty) {
        viewModel.getPromptByCategory(
          _selectedCategory,
          query: _searchController.text,
        );
      }
    } else if (_tabController.index == 3) {
      // Favorite tab
      if (viewModel.favoritePrompts == null ||
          viewModel.favoritePrompts!.isEmpty) {
        viewModel.getFavoritePrompts(query: _searchController.text);
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
    final favoritePrompts = viewModel.favoritePrompts ?? [];
    final categoryPrompts = viewModel.categoryPrompts ?? [];

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
                children: [
                  Text(
                    "Prompts",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/ic_add.svg',
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/prompts/new');
                    },
                  ),
                ],
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
                    tabLabels: const [
                      'Public',
                      'Private',
                      'Categories',
                      'Favorite',
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPromptList(prompts, viewModel, isPrivate: false),
                  _buildPromptList(privatePrompts, viewModel, isPrivate: true),
                  _buildCategoryTab(viewModel, categoryPrompts),
                  _buildPromptList(
                    favoritePrompts,
                    viewModel,
                    isPrivate: false,
                    isFavorite: true,
                  ),
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
    } else if (_tabController.index == 1) {
      viewModel.getPrivatePrompts(query: value);
    } else if (_tabController.index == 2) {
      viewModel.getPromptByCategory(_selectedCategory, query: value);
    } else if (_tabController.index == 3) {
      viewModel.getFavoritePrompts(query: value);
    }
  }

  Widget _buildCategoryTab(
    PromptViewmodel viewModel,
    List<PromptEntity> categoryPrompts,
  ) {
    return Stack(
      children: [
        Positioned.fill(
          child: _buildCategoryPromptList(categoryPrompts, viewModel),
        ),
        Positioned(
          left: 10,
          right: 10,
          bottom: 16,
          child: ElevatedButton.icon(
            onPressed: () => _openCategoryPicker(viewModel),
            icon: const Icon(Icons.arrow_drop_up, size: 20),
            label: Text('Category: $_selectedCategoryName'),

            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface.withAlpha(230),

              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,

              elevation: 4,
              shadowColor: Colors.black.withAlpha(100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: const Size(0, 36),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryPromptList(
    List<PromptEntity> prompts,
    PromptViewmodel viewModel,
  ) {
    final loadMoreState = viewModel.categoryLoadMoreState;
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
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
              if (prompt.isFavorite) {
                viewModel.removeFromFavorite(prompt.id);
              } else {
                viewModel.addPromptToFavorite(prompt.id);
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _openCategoryPicker(PromptViewmodel viewModel) async {
    final result = await Navigator.push<CategoryType>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            _CategoryPickerPage(selectedCategory: _selectedCategory),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _selectedCategory = result;
        _selectedCategoryName = result.name;
      });
      await viewModel.getPromptByCategory(
        _selectedCategory,
        query: _searchController.text,
      );
    }
  }

  Widget _buildPromptList(
    List<PromptEntity> prompts,
    PromptViewmodel viewModel, {
    required bool isPrivate,
    bool isFavorite = false,
  }) {
    final loadMoreState = isFavorite
        ? viewModel.favoriteLoadMoreState
        : (isPrivate
              ? viewModel.privateLoadMoreState
              : viewModel.allLoadMoreState);
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
              if (prompt.isFavorite) {
                viewModel.removeFromFavorite(prompt.id);
              } else {
                viewModel.addPromptToFavorite(prompt.id);
              }
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
      final isFavoriteTab = _tabController.index == 3;
      final isCategoryTab = _tabController.index == 2;
      final loadMoreState = isCategoryTab
          ? viewModel.categoryLoadMoreState
          : (isFavoriteTab
                ? viewModel.favoriteLoadMoreState
                : (isPrivateTab
                      ? viewModel.privateLoadMoreState
                      : viewModel.allLoadMoreState));
      final hasNext = isCategoryTab
          ? viewModel.categoryHasNext
          : (isFavoriteTab
                ? viewModel.favoriteHasNext
                : (isPrivateTab
                      ? viewModel.privateHasNext
                      : viewModel.allHasNext));

      if (loadMoreState == LoadMoreState.idle && hasNext) {
        debugPrint(
          'ShowPromptModalBottomSheet: Reached bottom, loading more prompts...',
        );
        if (isCategoryTab) {
          viewModel.loadMoreCategoryPrompts();
        } else if (isFavoriteTab) {
          viewModel.loadMoreFavoritePrompts();
        } else if (isPrivateTab) {
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
    } else if (_tabController.index == 1) {
      await viewModel.getPrivatePrompts(query: _searchController.text);
    } else if (_tabController.index == 2) {
      await viewModel.getPromptByCategory(
        _selectedCategory,
        query: _searchController.text,
      );
    } else if (_tabController.index == 3) {
      await viewModel.getFavoritePrompts(query: _searchController.text);
    }
  }

  void _handleItemTap(BuildContext context, PromptEntity prompt) {
    // get the content of the prompt and send it as a message, put it in the chat input box
    widget.chatViewModel.setInputMessage(prompt.content);
    Navigator.pop(context);
  }
}

class _CategoryPickerPage extends StatelessWidget {
  final CategoryType selectedCategory;

  const _CategoryPickerPage({required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.transparent),
          onPressed: () {},
        ),
        title: const Text('Select Category'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;
          final crossAxisCount = isWide ? 4 : 2;

          return GridView.count(
            primary: false,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.7,
            children: [
              for (final category in categories)
                CategoryItem(
                  categoryName: category.name,
                  iconPath: category.iconPath,
                  onTap: () => Navigator.pop(context, category.id),
                ),
            ],
          );
        },
      ),
    );
  }
}
