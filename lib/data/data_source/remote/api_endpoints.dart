final class ApiEndpoints {
  //health check
  static const String healthCheck = 'health-check';

  //auth
  static const String login = 'auth/login';
  static const String logout = 'auth/logout';
  static const String myInfo = 'auth/me';
  static const String companiesEdit = 'companies/{id}';
  static const String notifySubscription = 'auth/me/notify-subscription';
  static const String register = 'auth/register';
  static const String retryOTP = 'auth/otp';
  static const String verifyOTPSignUp = 'auth/verify-otp';
  static const String refreshToken = 'auth/refresh-token';
  static const String createBank = 'banks';
  static const String updateBank = 'banks/{id}';
  //users
  static const String users = 'users';
  static const String createUser = 'users';
  static const String detailUser = 'users/{id}';
  static const String updateUser = 'users/{id}';
  static const String deleteUser = 'users/{id}';

  static const String changePassword = 'users/{id}/password';

  static const String sendOTP = 'users/otp';
  static const String verifyOTP = 'users/verify-otp';
  static const String forgotPassword = 'users/forgot-password';
  //contract
  static const String contracts = 'contracts';
  static const String contractDetail = 'contracts/{id}';
  static const String pawnContracts = 'pawn-contracts';
  static const String pawnContractDetail = 'pawn-contracts/{id}';
  static const String exportPawnContract = 'export/pawn-contract/{id}';
  static const String exportPawnContractPreview =
      'export/pawn-contract/preview';
  static const String pawnContractTemplates = 'pawn-contracts/templates';
  static const String detailContractTemplate = 'pawn-contracts/legal/{id}';
  static const String updateContratTemplate = 'pawn-contracts/legal/{id}';
  static const String deleteContractTemplate = 'pawn-contracts/legal/{id}';
  static const String createContractTemplate = 'pawn-contracts/legal';
  static const String setDefaultContractTemplate =
      'pawn-contracts/legal/{id}/default';
  static const String templateKeys = 'pawn-contracts/legal-template-keys';
  static const String applyPenalty = 'pawn-contracts/apply-penalty/{id}';
  static const String assetCategories = 'asset-category';
  static const String uploadDocumentStream =
      'pawn-contracts/{id}/upload-document/stream';
  static const String uploadDocumentProgress = 'export/file-progress/{jobId}';
  //payments
  static const String partialPayment = 'payments/{id}/partial';
  static const String settlementPayment = 'payments/{id}/settlements';
  static const String exportSettlementPayment =
      'export/settlement-receipt/{paymentId}';

  //expenses
  static const String expenses = 'expenses';
  static const String expensesSummary = 'expenses/summary';
  static const String expensesRecent = 'expenses/recent';
  static const String expenseDetail = 'expenses/{id}';

  //investors
  static const String investors = 'investors';
  static const String investorsSummary = 'investors/summary';
  static const String investorDetail = 'investors/{id}';
  static const String investorInterestHistories =
      'investors/{id}/interest-payment-histories';
  static const String investorCalculateInterest =
      'investors/{id}/calculate-interest-periodic';
  static const String investorPayInterest = 'investors/{id}/pay-interest';
  static const String investorContributionWithdraw = 'investors/{id}/withdraw';
  static const String investorContributions = 'investors/{id}/contributions';
  static const String investorInvest = 'investors/{id}/invest';

  //customers
  static const String customers = 'customers';
  static const String customerDetail = 'customers/{id}';
  static const String customerUpdate = 'customers/{id}';
  static const String customerDelete = 'customers/{id}';
  static const String customerCheckEligibility = 'customers/check-eligibility';

  //dashboard
  static const String dashboardSummary = 'reports/summary';
  static const String dashboardCashflow = 'reports/cashflow';
  static const String dashboardExpenses = 'reports/expenses';
  static const String dashboardExport = 'export/business-activity-reports';

  //assets

  static const String assetManager = 'assets';

  //debt reminders
  static const String reminderDepts = 'reminder-depts';
  static const String reminderDeptDetail = 'reminder-depts/{contractId}';
  static const String reminderDeptHistories =
      'reminder-depts/{contractId}/histories';

  //notifications
  static const String notifications = 'notifications';
  static const String notificationDetail = 'notifications/{id}';
  static const String notificationRead = 'notifications/{id}/read';

  //warehouses
  static const String wareHousesCategories = 'warehouses/categories';
  static const String wareHouses = 'warehouses';
  static const String wareHousesOwner = 'warehouses/owner/{id}';
  static const String wareHousesCreate = 'warehouses';
  static const String wareHousesDetail = 'warehouses/{id}';
  static const String wareHousesUpdate = 'warehouses/{id}';
  static const String wareHousesDelete = 'warehouses/{id}';

  //Capital Transactions
  static const String capitalTransactionsHistories =
      'capital-transactions/histories';
  static const String paymentHistory = 'payments/histories';
  static const String capitalTransactionsFundTransfer =
      'capital-transactions/fund-transfers';
  static const String capitalTransactionsBalance =
      'capital-transactions/balance';

  //Tickets
  static const String exportTickets = 'export/payment-ticket';

  //advertisements
  static const String advertisements = 'advertisements';
  static const String advertisementsDismiss = 'advertisements/dismiss';

  static const String checkVersion = 'platform/check-version';

  // Sample module
  static const String sampleItems = '/sample/items';
}
