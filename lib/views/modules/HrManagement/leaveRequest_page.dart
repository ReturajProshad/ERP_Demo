import 'package:erp_d_and_a/models/leave_model.dart';
import 'package:erp_d_and_a/providers/hr_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveRequestPage extends StatelessWidget {
  const LeaveRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hrProvider = Provider.of<HrProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Requests"),
      ),
      body: hrProvider.leaves.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: hrProvider.leaves.length,
              itemBuilder: (context, index) {
                LeaveRequest leave = hrProvider.leaves[index];
                return ListTile(
                  title: Text("Leave for ${leave.type}"),
                  subtitle:
                      Text('From: ${leave.startDate} To: ${leave.endDate}'),
                  trailing: Text(leave.status),
                  leading: Icon(
                    leave.status == "Approved"
                        ? Icons.check_circle
                        : (leave.status == "Rejected"
                            ? Icons.cancel
                            : Icons.pending),
                    color: leave.status == "Approved"
                        ? Colors.green
                        : (leave.status == "Rejected"
                            ? Colors.red
                            : Colors.orange),
                  ),
                  onTap: () {
                    _updateLeaveStatus(context, leave);
                  },
                );
              },
            ),
    );
  }

  void _updateLeaveStatus(BuildContext context, LeaveRequest leaveRequest) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Leave Status"),
          content: const Text("Do you want to approve or reject this leave?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Provider.of<HrProvider>(context, listen: false)
                    .updateLeaveStatus(leaveRequest.id, 'Approved');
                Navigator.pop(context);
              },
              child: const Text("Approve"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<HrProvider>(context, listen: false)
                    .updateLeaveStatus(leaveRequest.id, 'Rejected');
                Navigator.pop(context);
              },
              child: const Text("Reject"),
            ),
          ],
        );
      },
    );
  }
}
