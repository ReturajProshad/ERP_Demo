import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/services/navigation_service.dart';
import 'package:erp_d_and_a/views/admin_dashboard.dart';
import 'package:erp_d_and_a/views/modules/employee_page.dart';
import 'package:erp_d_and_a/views/modules/finance_page.dart';
import 'package:erp_d_and_a/views/modules/hr_page.dart';

class DashboardService {
  static DashboardService instance = DashboardService();

  void gotodashboard(String role) {
    if (role == Constants.instances.admin) {
      NavigationService.navigateToAndRemove(AdminDashboard(
        name: Constants.instances.currentUser.name,
      ));
    } else if (role == Constants.instances.hr) {
      NavigationService.navigateToAndRemove(HrPage(
        role: role,
      ));
    } else if (role == Constants.instances.finance) {
      NavigationService.navigateToAndRemove(FinancePage());
    } else if (role == Constants.instances.employee) {
      NavigationService.navigateToAndRemove(EmployeePage());
    }
  }
}
