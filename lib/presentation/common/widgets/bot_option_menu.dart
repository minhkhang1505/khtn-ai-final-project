import 'package:flutter/material.dart';

class BotOptionMenu extends StatefulWidget {
  const BotOptionMenu({super.key});

  @override
  State<BotOptionMenu> createState() => _BotOptionMenuState();
}

class _BotOptionMenuState extends State<BotOptionMenu> {
  String selectedModel = "ChatGPT";

  final List<Map<String, dynamic>> models = [
    {
      "name": "ChatGPT Go",
      "description": "Our smartest model & more",
      "upgrade": true,
    },
    {
      "name": "ChatGPT",
      "description": "Great for everyday tasks",
      "upgrade": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return PopupMenuButton<String>(
      onSelected: (value) {
        setState(() => selectedModel = value);
      },
      color: colorScheme.surfaceBright,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      itemBuilder: (context) => models.map((model) {
        return PopupMenuItem<String>(
          value: model["name"],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              const Icon(Icons.auto_awesome, size: 20),
              const SizedBox(width: 10),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model["name"],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      model["description"],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (model["upgrade"])
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Upgrade",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceBright,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedModel, style: const TextStyle(fontSize: 15)),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
