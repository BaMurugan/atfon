class ApiPaths {
  static const String devServerAddress = "https://staging.atofon.com/be/api";
  static const String sellerMap =
      "https://api.data.gov.in/resource/5c2f62fe-5afa-4119-a499-fec9d604d5bd?api-key=579b464db66ec23bdd0000013f2ef12c834848847a0be63f27f891da&format=json&filters[pincode]=";

  static const String sellerSignIn = "/seller-auth/signIn";
  static const String sellerConfirmSignUp = "/seller-auth/confirmSignUp";
  static const String sellerResetPassword = "/seller-auth/resetPassword";
  static const String sellerResendCode = "/seller-auth/resendCode";
  static const String sellerStatistics = "/seller-statistics";
  static const String sellerProfile = "/seller-auth/getProfile";
  static const String sellerEmailUpdate = "/seller-auth/emailupdate";
  static const String sellerSignUp = "/seller-auth/signup";
  static const String sellerPoints = "/users-points";
  static const String sellerPointsTransaction = "/points-transactions/user";
  static const String sellerUpdateMapLocation = "/update/maplocation";
  static const String sellerVerifyEmail = "/seller-auth/verifyuseremail";
  static const String sellerChangePassword = "/seller-auth/changePassword";
  static const String sellerSearchEnquiries = "/quote-enquiries/search";
  static const String sellerSetCreditNoteNumber = "/set-credit-note-number";
  static const String sellerSearchConfirmPassword =
      "/seller-auth/confirmPassword";

  static const String sellerSignInWithOTP = '/seller-auth/signIn-with-otp';
  static const String sellerSignInOTP = '/seller-auth/verify-signin-otp';
  static const String sellerOrders = '/seller-orders';
  static const String disputeOrder = '/dispute-order';
  static const String sellerUpdateSplitOrder = '/update-split-order';
  static const String sellerBankDetails = '/bank-details';
  static const String sellerUpdateBankDetails = '/update/bank-details';
  static const String sellerOrdersSearch = '/seller-orders/search';
  static const String sellerSubmit = '/submit';

  static const String sellerQuotes = '/seller-quotes';
  static const String sellerProductBulk = '/products/bulk';
  static const String sellerProductSeller = '/products-seller';
  static const String sellerProduct = '/sellers-products';
  static const String sellersProductsBulk = '/sellers-products/bulk';
  static const String sellers = '/sellers';

  static const String sellerQuotesSearch = '/seller-quotes/search';
  static const String sellerQuotesCreateQuote =
      '/seller-quotes/create-for-enquiry';
  static const String sellerUpdateQuoteLineItem = '/seller-quote-items';
  static const String sellerWallet = 'wallets/my-wallet';
  static const String sellerWalletTransaction = '/wallet_transactions/search';
  static const String sellerVerifyOrder = '/verify-order';
  static const String sellerChangeUOM = '/change-uom';
  static const String sellerSendDeliveryConfirmation =
      '/send-delivery-confirmation-otp';

  static const String deliveryChargesType = '/delivery-charge-types';
  static const String deliveryPersonsSearch = '/delivery-persons/search';
  static const String deliveryPersons = '/delivery-persons';

  static const String pincodesHierarchy = '/pincodes/hierarchy';
  static const String pincodeSearch = '/pincodes/search';
  static const String selfPickUpPincodeSearch =
      '/seller-self-pickup-pincodes/search';
  static const String selfPickUpPincode = '/seller-self-pickup-pincodes';

  static const String sellerServicingAreas = '/seller-service-areas';
  static const String sellerShipmentInvoice = '/shipments-invoices';

  static const String products = '/products';
  static const String productsSearch = '/products/search';

  static const String manufacturers = '/manufacturers';
  static const String productsHierarchy = '/products/hierarchy';

  static const String brands = '/brands';
  static const String cheque = '/cheque';

  static const String userAddress = '/user-addresses';
  static const String userProfileAddress = '/user-addresses/profile-address';
  static const String sellerTypeChangeCreate = '/seller-type-change/create';
  static const String sellerTypeChange = '/seller-type-change';
  static const String sellerUsersUser = '/users/user';
  static const String sellerUsersUpdateName = '/users/update/name';
  static const String sellerItTax = '/seller-it-tax-deductions/';
  static const String sellerGstTax = '/seller-gst-tax-deductions/';
  static const String sellerUserNotification = '/users-notification';
  static const String sellerUsersUpdateNotification =
      '/users/update/notification';

  static const String sellerTermsAndConditionsLatest =
      '/terms-and-conditions/seller/latest';

  static const String sellerShipments = '/shipments';
  static const String sellerServiceArea = '/seller-service-areas';
  static const String sellerInquiriesSearch = '/user-inquiries/seller/search';
  static const String sellerInquiries = '/user-inquiries';
  static const String sellerGstSearch = '/gst/search';
  static const String sellerUomValue = '/uom-values/uom/';
  static const String sellerOrderUpdateTolerance =
      '/seller-orders/update-tolerance';
  static const String sellerUserDelete = '/user-accounts/delete-my-account';
  static const String sellerUserWallet = '/user-Wallet';
}
