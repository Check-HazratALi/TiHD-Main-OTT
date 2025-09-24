import 'dart:math';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/General.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:tihd/utils/app_common.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// Call this function after payment success
Future<void> postPaymentSuccess({
  required int planId,
  required int userId,
  required double amount,
  required String tranId,
}) async {
  final url = Uri.parse('https://tichannel.com/api/payment/success');

  final body = {
    "plan_id": planId.toString(),
    "user_id": userId.toString(),
    "amount": amount.toString(),
    "tran_id": tranId,
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // Add auth headers if your API requires
        // 'Authorization': 'Bearer YOUR_TOKEN',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print("✅ Payment success posted to backend: ${response.body}");
    } else {
      print(
          "❌ Failed to post payment: ${response.statusCode} ${response.body}");
    }
  } catch (e) {
    print("⚠️ Error posting payment success: $e");
  }
}

String generateTranId() {
  final now = DateTime.now();
  final random = Random().nextInt(99999);
  return "TNX${now.millisecondsSinceEpoch}$random";
}

final customerInfo = {
  "state": "Dhaka",
  "name": loginUserData.value.fullName,
  "email": loginUserData.value.email,
  "address1": "Dhaka",
  "city": "Dhaka",
  "postcode": "1340",
  "country": "Bangladesh",
  "phone": loginUserData.value.mobile,
};

final productInfo = {
  "name": "Subscription Plan",
  "category": "Service",
  "general": "General Purpose",
  "profile": "general",
};

void sslcommerz({
  required double totalAmount,
  required int planId,
  required int userId,
}) async {
  String tranId = generateTranId();

  final additionalInfo = {
    "valueA": planId.toString(), // planId dynamic
    "valueB": userId.toString(), // userId dynamic
  };

  Sslcommerz sslcommerz = Sslcommerz(
    initializer: SSLCommerzInitialization(
      store_id: "timed68bfc4b5ba8e3",
      store_passwd: "timed68bfc4b5ba8e3@ssl",
      total_amount: totalAmount, // dynamic amount
      currency: SSLCurrencyType.BDT,
      tran_id: tranId,
      product_category: productInfo["category"]!,
      sdkType: SSLCSdkType.TESTBOX,
    ),
  );

  sslcommerz.addCustomerInfoInitializer(
    customerInfoInitializer: SSLCCustomerInfoInitializer(
      customerState: customerInfo["state"]!,
      customerName: customerInfo["name"]!,
      customerEmail: customerInfo["email"]!,
      customerAddress1: customerInfo["address1"]!,
      customerCity: customerInfo["city"]!,
      customerPostCode: customerInfo["postcode"]!,
      customerCountry: customerInfo["country"]!,
      customerPhone: customerInfo["phone"]!,
    ),
  );

  sslcommerz.addProductInitializer(
    sslcProductInitializer: SSLCProductInitializer(
      productName: productInfo["name"]!,
      productCategory: productInfo["category"]!,
      general: General(
        general: productInfo["general"]!,
        productProfile: productInfo["profile"]!,
      ),
    ),
  );

  sslcommerz.addAdditionalInitializer(
    sslcAdditionalInitializer: SSLCAdditionalInitializer(
      valueA: additionalInfo["valueA"],
      valueB: additionalInfo["valueB"],
    ),
  );

  final response = await sslcommerz.payNow();

  if (response.status == 'VALID') {
    // Post to your backend
    await postPaymentSuccess(
      planId: planId,
      userId: userId,
      amount: totalAmount,
      tranId: response.tranId!,
    );
  } else if (response.status == 'FAILED') {
    print("❌ Payment Failed");
  } else if (response.status == 'Closed') {
    print("🚫 Payment Closed by User");
  }
}
