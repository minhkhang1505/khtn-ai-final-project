import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'edit_bot_page.dart';

/// Card to display individual AI bot information
class BotCard extends StatelessWidget {
  final String botName;
  final String botDescription;
  final String category;
  final String model;
  final String state;
  final String prompt;

  const BotCard({
    super.key,
    required this.botName,
    required this.botDescription,
    required this.category,
    required this.state,
    required this.model,
    required this.prompt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Bot icon
                SvgPicture.asset(
                  'assets/icons/ic_bot.svg',
                  width: 40,
                  height: 40,
                ),

                const SizedBox(width: 8),

                // Name of Bot
                Text(
                  botName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                // Edit Bot button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Edit Bot page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditBotPage(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.grey.shade300;
                        }
                        if (states.contains(WidgetState.hovered)) {
                          return Colors.grey.shade400;
                        }
                        return Colors.transparent; 
                      },
                    ),
                    elevation: WidgetStateProperty.all(0), 
                    overlayColor: WidgetStateProperty.all(Colors.transparent), 
                    shape: WidgetStateProperty.all(
                      const CircleBorder(), 
                    ),
                    padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                  ),
                  child: const Icon(
                    Icons.settings,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // Description of Bot
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                botDescription,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 24),

            // Category and Model Chips
            Row(
              children: [
                Chip(
                  label: Text(
                    category,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    model,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}