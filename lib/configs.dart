// ignore_for_file: constant_identifier_names

import 'package:country_picker/country_picker.dart';

const APP_NAME = 'Streamit';
const APP_LOGO_URL = '$DOMAIN_URL/img/logo/mini_logo.png';
const DEFAULT_LANGUAGE = 'en';
const DASHBOARD_AUTO_SLIDER_SECOND = 6000;
const CUSTOM_AD_AUTO_SLIDER_SECOND_VIDEO = 30000;
const CUSTOM_AD_AUTO_SLIDER_SECOND_IMAGE = 30000;
const LIVE_AUTO_SLIDER_SECOND = 5;

///DO NOT ADD SLASH HERE
const DOMAIN_URL = "https://tichannel.com";
const BASE_URL = '$DOMAIN_URL/api/';

const APP_APPSTORE_URL = '';

///LOCAL VIDEO TYPE URL
const LOCAL_VIDEO_DOMAIN_URL = '$DOMAIN_URL/storage/streamit-laravel/';

// //region STRIPE
// const STRIPE_URL = 'https://api.stripe.com/v1/payment_intents';
// const STRIPE_merchantIdentifier = "merchant.flutter.stripe.test";
// const STRIPE_MERCHANT_COUNTRY_CODE = 'BD';
// const STRIPE_CURRENCY_CODE = 'INR';
// //endregion

// //region RazorPay
// const String commonSupportedCurrency = 'INR';
// //endregion

// //region  PAYSTACK
// const String payStackCurrency = "NGN";
// //endregion

// // PAYPAl
// const String payPalSupportedCurrency = 'USD';
// //endregion

//ADs
// //Android
const INTERSTITIAL_AD_ID = "";
const BANNER_AD_ID = "";

// //IOS
const IOS_INTERSTITIAL_AD_ID = "";
const IOS_BANNER_AD_ID = "";

//region defaultCountry
Country get defaultCountry => Country(
      phoneCode: "880",
      countryCode: "BD",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Bangladesh",
      example: "1812345678",
      displayName: "Bangladesh (BD) [+880]",
      displayNameNoCountryCode: "Bangladesh (BD)",
      e164Key: "880-BD-0",
      fullExampleWithPlusSign: "+8801812345678",
    );
//endregion
