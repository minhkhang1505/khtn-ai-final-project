import 'package:flutter/material.dart';
import 'workflows_cart.dart' show WorkflowsCart, Workflow;
import 'package:khtn_ai_final_project/constants/constant.dart' show AppBarInfo;

class EditAgentPage extends StatelessWidget {
  const EditAgentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            // IconButton(
            //   onPressed: () => 
            //   { 
            //     //TODO: Navigate back to agents page
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
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status & Actions Card 
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
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
                                    fontSize: 12,
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
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('Run Now'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.edit_outlined),
                                label: const Text('Edit Agent'),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Delete button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.redAccent),
                            label: const Text(
                              'Delete Agent',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Workflows Card
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        WorkflowsCart(workflow: Workflow.emailTriage),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

