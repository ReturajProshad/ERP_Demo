# ERP App Documentation

## 1. Authentication & Role Management

### Implementation Details:
- **Authentication:** Implemented using Firebase for secure user login/logout.
- **Role Management:** User roles (Admin, HR, Finance, Employee) are dynamically fetched and assigned.
- **Token Storage:** Authentication tokens are securely stored using Hive for persistent login sessions.
  

### Functionalities:
- **Admin** has full access to all modules and can change user roles.
- **HR** can add employees but cannot change roles.
- **Finance module** is currently using demo data and is not integrated with Firebase.
- **Employee login system** is added but not yet implemented.
- **When admin Added a user A reset password link is sent to the user email**
- default Password For All User is **TemporaryPassword123**
---

## 2. Role-Based Dashboard UI

### Dashboard Features:

- **Admin Dashboard:**
  - Overview of all modules (Users, Inventory, HR, Finance, etc.).
  - Ability to manage roles (assign HR, Finance, Employee, Admin).

- **HR Dashboard:**
  - Employee management (Add employees, View employee status).
  - Manage leave requests and payroll.
  - Cannot change employee roles.

- **Finance Dashboard (Demo Data Only):**
  - View and manage billing, invoices, financial reports (Not integrated with Firebase).

- **Employee Dashboard (Not Implemented Yet):**
  - Employee login system is set up but lacks full functionality.

---

## 3. API Integration & State Management

### Implementation Details:
- **Firebase** serves as the backend for authentication and role-based data storage.
- **Hive** is used for local storage (caching, authentication tokens).
- **State Management:** Implemented using Provider for managing app state efficiently.

### Key Features:
- Data is fetched dynamically from Firebase where implemented.
- Finance data is currently static (demo-based).
- Role-based access control ensures security and usability.

---

## 4. Performance Optimization & Best Practices

### Optimizations Implemented:

- **Network Optimization:**
  - Firebase Firestore reads are optimized to minimize unnecessary requests.
  - Local storage via Hive reduces dependency on frequent API calls.

- **User Experience Enhancements:**
  - Splash Screen added for a smooth startup experience.
  - Simple page transition animations for better navigation flow.


```
├── lib/
│   ├── firebase_options.dart
│   ├── main.dart
│   ├── customWidgets/
│   │   ├── Contants.dart
│   │   └── transitions.dart
│   ├── models/
│   │   ├── biling_model.dart
│   │   ├── employee_model.dart
│   │   ├── inventory_model.dart
│   │   ├── invoice_model.dart
│   │   ├── leave_model.dart
│   │   ├── payroll_model.dart
│   │   ├── report_model.dart
│   │   ├── user_model.dart
│   │   └── user_model.g.dart
│   ├── providers/
│   │   ├── biling_provider.dart
│   │   ├── hr_provider.dart
│   │   ├── invoice_provider.dart
│   │   ├── provider_bindings.dart
│   │   ├── report_provider.dart
│   │   └── user_provider.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── dashboard_service.dart
│   │   ├── inventory_service.dart
│   │   ├── navigation_service.dart
│   │   └── transaction_service.dart
│   └── views/
│       ├── add_user.dart
│       ├── admin_dashboard.dart
│       ├── login_page.dart
│       ├── splash_screen.dart
│       └── modules/
│           ├── employee_page.dart
│           ├── finance_page.dart
│           ├── hr_page.dart
│           ├── inventory_module.dart
│           ├── user_module.dart
│           ├── HrManagement/
│           │   ├── add_employee.dart
│           │   ├── employee_list.dart
│           │   ├── leaveRequest_page.dart
│           │   └── payroll_page.dart
│           └── financeManagement/
│               ├── biling.dart
│               ├── invoices.dart
│               └── reports.dart

```
