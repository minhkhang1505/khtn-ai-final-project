import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'edit_agent_page.dart' show EditAgentPage;

/// Card to display individual AI agent information
class AgentCard extends StatelessWidget {
  final String agentName;
  final String agentDescription;
  final String workflows;
  final String state;

  const AgentCard({
    super.key,
    required this.agentName,
    required this.agentDescription,
    required this.workflows,
    required this.state,
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
                // Agent icon
                SvgPicture.asset(
                  'assets/icons/ic_agent.svg',
                  width: 40,
                  height: 40,
                ),

                const SizedBox(width: 8),

                // Name of Agent
                Text(
                  agentName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                // Edit Agent button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Edit Agent page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditAgentPage(),
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
            // Description of Agent
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                agentDescription,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 24),

            // Workflows info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.fork_right, color: Theme.of(context).primaryColor, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      workflows,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('New Email'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Button
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text(
                      'Run Now',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    // TODO: Change to appropriate action with workflow 
                    'Add to Chat',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
