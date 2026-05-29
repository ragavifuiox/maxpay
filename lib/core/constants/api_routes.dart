import 'package:maxpay/core/data/model/support_model.dart';

class ApiRoutes {
  static const baseURL = "http://139.59.91.7/test_paylinkonline.in/public/api";
  static const login = "/retailer_login_sendotp";
  static const verifyotp = "/retailer_login_verifyOtp";
  static const news = "/get_news";
  static const createpin = "/create_pin";
  static const walletbalance = "/get_wallet_balance";
  static const transsucfail = "/home_card";
  static const getprofile = "/get_profile";
  static const fingerprint = "/update_fingerprint";
  static const productype = "/get_producttype";
  static const plans = "/get_product/";
  static const complaints = "/get_complaint"; 
  static const bank = "/get_bank";
  static const walletrequest = "/create_wallet_request";
  static const addstaff = "/add_staff";
  static const stafflist = "/get_staff";
  static const popupMessage = "/get_popup_message";
  static const earning = "/total_earnings";
  static const credit = "/total_credit";
  static const searchearnings = "/my_earnings";
  static const Support = "/get_support";

}