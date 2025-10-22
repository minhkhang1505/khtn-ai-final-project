import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';

/// Prompts page - Manage AI prompts
class PromptsPage extends StatefulWidget {
  const PromptsPage({super.key});

  @override
  State<PromptsPage> createState() => _PromptsPageState();
}

class _PromptsPageState extends State<PromptsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleAddPrompt() {}

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Prompts'),
                SizedBox(height: 4),
                Text(
                  'Browse and manage your AI prompts',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            IconButton(
              onPressed: _handleAddPrompt,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: AppBorderRadius.extraExtraLarge,
                child: Container(
                  height: 40,
                  color: colorScheme.surfaceContainerHigh,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: AppBorderRadius.extraExtraLarge,
                      ),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      labelColor: colorScheme.onPrimary,
                      unselectedLabelColor: colorScheme.primary,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      tabs: const [
                        Tab(text: "All Prompts"),
                        Tab(text: "Categories"),
                        Tab(text: "Favorite"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Tab bar view of each item in tabbar
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: <Widget>[
                      for (var prompt in samplePrompts)
                        PromptItem(prompt: prompt),
                    ],
                  ),
                  GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(16),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 1.7,
                    children: <Widget>[
                      for (var category in categories)
                        CategoryItem(
                          categoryName: category.name,
                          iconPath: category.iconPath,
                        ),
                    ],
                  ),
                  Center(child: Text("Favorite content")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Category {
  final String name;
  final String iconPath;

  Category({required this.name, required this.iconPath});
}

final categories = [
  Category(name: "Coding", iconPath: "assets/icons/ic_coding.svg"),
  Category(name: "Career", iconPath: "assets/icons/ic_career.svg"),
  Category(name: "Business", iconPath: "assets/icons/ic_business.svg"),
  Category(name: "Education", iconPath: "assets/icons/ic_education.svg"),
  Category(name: "Marketing", iconPath: "assets/icons/ic_marketing.svg"),
  Category(name: "Writing", iconPath: "assets/icons/ic_writing.svg"),
  Category(name: "Fun", iconPath: "assets/icons/ic_fun.svg"),
  Category(name: "Chatbot", iconPath: "assets/icons/ic_bot.svg"),
  Category(name: "Productivity", iconPath: "assets/icons/ic_productivity.svg"),
  Category(name: "CEO", iconPath: "assets/icons/ic_ceo.svg"),
  Category(name: "Other", iconPath: "assets/icons/ic_other.svg"),
];

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final String iconPath;
  const CategoryItem({
    super.key,
    required this.categoryName,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.large,
        color: colorScheme.secondaryContainer.withAlpha(100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                categoryName,
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Prompt {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String category;
  final String content;
  final String? description;
  final bool isPublic;
  final String language;
  final String title;
  final String userId;
  final String userName;
  final bool isFavorite;

  Prompt({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.content,
    this.description,
    required this.isPublic,
    required this.language,
    required this.title,
    required this.userId,
    required this.userName,
    required this.isFavorite,
  });

  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      category: json['category'] ?? '',
      content: json['content'] ?? '',
      description: json['description'],
      isPublic: json['isPublic'] ?? false,
      language: json['language'] ?? '',
      title: json['title'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'category': category,
      'content': content,
      'description': description,
      'isPublic': isPublic,
      'language': language,
      'title': title,
      'userId': userId,
      'userName': userName,
      'isFavorite': isFavorite,
    };
  }
}

final List<Prompt> samplePrompts = [
  Prompt(
    id: "p1",
    createdAt: "2025-10-20T10:00:00Z",
    updatedAt: "2025-10-21T09:00:00Z",
    category: "Productivity",
    content: "Write a daily plan to maximize focus and minimize distractions.",
    description: "A prompt to help organize daily priorities effectively.",
    isPublic: true,
    language: "en",
    title: "Daily Focus Planner",
    userId: "u101",
    userName: "Alice",
    isFavorite: true,
  ),
  Prompt(
    id: "p2",
    createdAt: "2025-10-19T14:30:00Z",
    updatedAt: "2025-10-20T15:00:00Z",
    category: "Coding",
    content:
        "Explain the difference between stateful and stateless widgets in Flutter.",
    description:
        "A coding-related educational question about Flutter UI structure.",
    isPublic: true,
    language: "en",
    title: "Flutter Widget Types",
    userId: "u102",
    userName: "Bob",
    isFavorite: false,
  ),
  Prompt(
    id: "p3",
    createdAt: "2025-10-18T08:15:00Z",
    updatedAt: "2025-10-18T09:30:00Z",
    category: "AI Writing",
    content: "Generate a short story about an AI that learns to dream.",
    description: "A creative writing prompt exploring AI consciousness.",
    isPublic: true,
    language: "en",
    title: "The Dreaming AI",
    userId: "u103",
    userName: "Charlie",
    isFavorite: true,
  ),
  Prompt(
    id: "p4",
    createdAt: "2025-10-17T12:00:00Z",
    updatedAt: "2025-10-18T08:00:00Z",
    category: "Career",
    content: "Give me 5 strategies to improve communication in a remote team.",
    description: "Useful for professionals managing distributed teams.",
    isPublic: false,
    language: "en",
    title: "Remote Team Communication Tips",
    userId: "u104",
    userName: "Diana",
    isFavorite: false,
  ),
];

class PromptItem extends StatelessWidget {
  final Prompt prompt;
  const PromptItem({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.large,
        border: Border.all(color: colorScheme.outline),
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(prompt.title),
                    Text(prompt.description ?? ''),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        prompt.isFavorite ? Icons.star : Icons.star_border,
                        color: prompt.isFavorite
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
