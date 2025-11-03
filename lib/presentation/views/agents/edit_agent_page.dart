import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'workflows/workflow_card.dart' show WorkflowsCart;
import 'package:khtn_ai_final_project/data/models/workflow_model.dart' show Workflow;
import 'package:khtn_ai_final_project/core/constants/constant.dart' show AppBarInfo, AppSpacing;
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart' show ResponsiveHelper;

class EditAgentPage extends StatelessWidget {
  const EditAgentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        toolbarHeight: AppBarInfo.height,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            // IconButton(
            //   onPressed: () => 
            //   { 
            //     
            //   },
            //   icon: const Icon(Icons.arrow_back),
            //   tooltip: 'Back',
            // ),
            // const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email Assistant',
                  style: AppBarInfo.titleTextStyle,
                ),

                SizedBox(height: 4),
                
                Text(
                  'Handles email workflows',
                  style: AppBarInfo.subtitleTextStyle,
                ),
              ],
            ),
          ],
        ),
      centerTitle: false,
      actions: const [
        Padding(
            padding: EdgeInsets.only(right: 16),
            child: Chip(
              label: Text(
                'Active',
                style: TextStyle(color: Colors.green),
              ),
              backgroundColor: Color(0xFFE8F5E9),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.contentWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status & Actions Card 
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Status & Actions',
                          style:
                              TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        const SizedBox(height: 16),

                        // Active toggle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Active Status',
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Enable or disable this agent',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Switch(value: true, onChanged: (v) {}, ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppBorderRadius.medium,
                                  ),
                                  side: const BorderSide(color: Colors.deepPurple), 
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                ),
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('Run Now'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppBorderRadius.medium,
                                  ),
                                  side: const BorderSide(color: Colors.deepPurple), 
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                ),
                                icon: const Icon(Icons.edit_outlined),
                                label: const Text('Edit Agent'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.cardSpacing),

                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  margin: const EdgeInsets.all(0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'Basic Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Name and describe your agent',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Agent Name label
                        const Text(
                          'Agent Name *',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Agent Name input
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'e.g., Email Assistant',
                            hintStyle: const TextStyle(color: Colors.black45),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: AppBorderRadius.medium,
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Description label
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Description input
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'What does this agent do?',
                            hintStyle: const TextStyle(color: Colors.black45),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: AppBorderRadius.medium,
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Workflows Card
                Card(
                  shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Workflows',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Add'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '1 workflow(s) configured',
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        const SizedBox(height: 16),

                        // Workflow
                        WorkflowsCart(workflowType: Workflow.emailTriage as dynamic),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.cardSpacing),
                
                // Delete button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.medium,
                          ),
                          side: BorderSide(color: Theme.of(context).primaryColor),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.medium,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        ),
                        child: const Text(
                          'Delete Agent',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

