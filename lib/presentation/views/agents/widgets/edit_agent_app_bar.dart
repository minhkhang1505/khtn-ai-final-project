import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';

class EditAgentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AgentModel agent;
  const EditAgentAppBar({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: false,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            agent.name,
            style: AppBarInfo.titleTextStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 4),
          if (ResponsiveHelper.isDesktop(context) ||
              ResponsiveHelper.isTablet(context))
            Text(
              agent.description,
              style: AppBarInfo.subtitleTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Chip(
            label: Text(
              agent.status,
              style: TextStyle(
                color: agent.status == 'Active' ? Colors.green : Colors.red,
              ),
            ),
            backgroundColor: agent.status == 'Active'
                ? Colors.green.withValues(alpha: 0.2)
                : Colors.red.withValues(alpha: 0.2),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
