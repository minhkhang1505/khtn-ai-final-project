import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'package:khtn_ai_final_project/data/models/workflow_model.dart';

/// Card to display individual AI agent information
class AgentCard extends StatelessWidget {
  final AgentModel agent;
  static const MAX_FEATURE_LENGTH = 15;

  const AgentCard({
    super.key,
    required this.agent,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.surfaceContainerLow,
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
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),

                // Name of Agent
                Expanded(
                  child: Text(
                    agent.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),

                // Edit Agent button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/agents/edit', arguments: agent);
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
                    shape: WidgetStateProperty.all(const CircleBorder()),
                    padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                  ),
                  child: Icon(
                    Icons.settings,
                    size: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            // Description of Agent
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                agent.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),

            // Workflows info
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              addAutomaticKeepAlives: false,
              itemCount: agent.workflows.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final workflow = agent.workflows[index];

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant.withAlpha(110),
                    borderRadius: AppBorderRadius.medium,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.fork_right, color: colorScheme.primary, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          workflow.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Feature tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: colorScheme.outline.withAlpha(150)),
                          borderRadius: AppBorderRadius.largeIncreased,
                        ),
                        child: Text(
                          workflow.feature.length > MAX_FEATURE_LENGTH
                            ? '${workflow.feature.substring(0, 15)}...'
                            : workflow.feature,
                          style: TextStyle(color: colorScheme.primary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            
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
                      side: BorderSide(
                        color: colorScheme.outline.withAlpha(150),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppBorderRadius.medium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    side: BorderSide(color: colorScheme.outline.withAlpha(150)),
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
