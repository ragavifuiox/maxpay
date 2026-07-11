import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maxpay/controllers/wallet_request_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/get_bank_model.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class WalletRequestScreen extends StatelessWidget {
  WalletRequestScreen({super.key});

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  final GetBankController controller =
      Get.put(
    GetBankController(
      bankusecase: sl(),
      
      walletRequestUsecase: sl(), 
      dueAmountUsecase: sl(),
    ),
  );

  final TextEditingController amountController =
      TextEditingController();

  final TextEditingController utrController =
      TextEditingController();

  final TextEditingController
      descriptionController =
      TextEditingController();

  final TextEditingController
      receiptController =
      TextEditingController();

  final RxString paymentType = ''.obs;

  final Rx<File?> selectedImage =
      Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    return Scaffold(
      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
            Theme.of(context)
                .appBarTheme
                .backgroundColor,

        elevation: 0,
        centerTitle: false,
        

        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color:
        //         Theme.of(context)
        //             .colorScheme
        //             .onSurface,
        //   ),

        //   onPressed: () {
        //     Get.back();
        //   },
        // ),

        title: Text(
          "Wallet Request",
          style: TextStyle(
            color:
                Theme.of(context)
                    .colorScheme
                    .onSurface,

            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: Form(
        key: _formKey,

        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              /// Due Amount
              Container(
                width: double.infinity,

                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                ),

                decoration: BoxDecoration(
                  color: Colors.red,

                  borderRadius:
                      BorderRadius.circular(
                    8.r,
                  ),
                ),

                child: Column(
                  children: [
                    Text(
                      "Due Amount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 4.h),

                Obx(() {
  return Text(
    "₹ ${controller.dueamount.value?.code?.pendingAmount ?? 0}",
    style: TextStyle(
      color: Colors.white,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    ),
  );
})
                  ],
                ),
              ),

              SizedBox(height: 22.h),

              /// Amount
              buildLabel(
                context,
                "Amount",
              ),

              buildTextField(
                context: context,
                controller:
                    amountController,
                hint: "Enter Amount",
              ),

              SizedBox(height: 16.h),

              /// Payment Type
              buildLabel(
                context,
                "Payment Type",
              ),

              Obx(
                () =>
                    DropdownButtonFormField<
                        String>(
                  dropdownColor:
                      isDark
                          ? const Color(
                            0xFF1E1E1E,
                          )
                          : Colors.white,

                  initialValue: paymentType
                          .value
                          .isEmpty
                      ? null
                      : paymentType.value,

                  decoration:
                      inputDecoration(
                    context,
                    "Select",
                  ),

                  style: TextStyle(
                    color:
                        Theme.of(context)
                            .colorScheme
                            .onSurface,
                  ),

                  icon: Icon(
                    Icons
                        .keyboard_arrow_down,

                    color:
                        Theme.of(context)
                            .colorScheme
                            .onSurface,
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return "Please select payment type";
                    }
                    return null;
                  },

                  items: const [
                    DropdownMenuItem(
                      value: "received",
                      child:
                          Text("Paid"),
                    ),

                    DropdownMenuItem(
                      value:
                          "not_received",

                      child: Text(
                        "Pending",
                      ),
                    ),
                  ],

                  onChanged: (value) {
                    paymentType.value =
                        value ?? "";
                  },
                ),
              ),

              SizedBox(height: 16.h),

              /// Bank Name
              buildLabel(
                context,
                "Bank Name",
              ),

              Obx(() {
                return DropdownButtonFormField<
                    Data>(
                  dropdownColor:
                      isDark
                          ? const Color(
                            0xFF1E1E1E,
                          )
                          : Colors.white,

                  initialValue: controller
                      .selectedPlan
                      .value,

                  decoration:
                      inputDecoration(
                    context,
                    "Select Bank",
                  ),

                  hint: Text(
                    "Select Bank",

                    style: TextStyle(
                      color:
                          Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                    ),
                  ),

                  style: TextStyle(
                    color:
                        Theme.of(context)
                            .colorScheme
                            .onSurface,
                  ),

                  validator: (value) {
                    if (value == null) {
                      return "Please select bank";
                    }
                    return null;
                  },

                  items: controller.plans
                      .map((bank) {
                    return DropdownMenuItem<
                        Data>(
                      value: bank,

                      child: Text(
                        bank.bankName ??
                            '',
                      ),
                    );
                  }).toList(),

                  onChanged:
                      (Data? value) {
                    controller
                        .selectedPlan
                        .value = value;
                  },
                );
              }),

              SizedBox(height: 16.h),

              /// UTR
              buildLabel(
                context,
                "UTR No",
              ),

              buildTextField(
                context: context,
                controller:
                    utrController,
                hint: "Enter UTR No",
              ),

              SizedBox(height: 16.h),

              /// Description
              buildLabel(
                context,
                "Description",
              ),

              buildTextField(
                context: context,
                controller:
                    descriptionController,
                hint: "Write Here",
                maxLines: 3,
              ),

              SizedBox(height: 16.h),

              /// Upload
              buildLabel(
                context,
                "Upload",
              ),

              Obx(() {
                return GestureDetector(
                  onTap: () async {
                    await pickImage();
                  },

                  child: Container(
                    width: double.infinity,

                    padding:
                        EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          isDark
                              ? const Color(
                                0xFF1E1E1E,
                              )
                              : const Color(
                                0xFFF5F5F5,
                              ),

                      borderRadius:
                          BorderRadius.circular(
                        10.r,
                      ),

                      border: Border.all(
                        color:
                            Colors
                                .grey
                                .shade300,
                      ),
                    ),

                    child:
                        selectedImage
                                    .value !=
                                null
                            ? Column(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(
                                      10.r,
                                    ),

                                    child:
                                        Image.file(
                                      selectedImage
                                          .value!,
                                      height:
                                          160.h,
                                      width:
                                          double
                                              .infinity,
                                      fit: BoxFit
                                          .cover,
                                    ),
                                  ),

                                  SizedBox(
                                    height:
                                        10.h,
                                  ),

                                  Text(
                                    "Image Selected",

                                    style:
                                        TextStyle(
                                      fontSize:
                                          13.sp,
                                      color: Colors
                                          .green,

                                      fontWeight:
                                          FontWeight
                                              .w600,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Icon(
                                    Icons
                                        .cloud_upload_outlined,

                                    size:
                                        32.sp,

                                    color:
                                        Theme.of(
                                              context,
                                            )
                                            .colorScheme
                                            .onSurfaceVariant,
                                  ),

                                  SizedBox(
                                    height:
                                        12.h,
                                  ),

                                  Text(
                                    "Browse and choose the files you want to upload from your device",

                                    textAlign:
                                        TextAlign
                                            .center,

                                    style:
                                        TextStyle(
                                      fontSize:
                                          12.sp,

                                      color:
                                          Theme.of(
                                                context,
                                              )
                                              .colorScheme
                                              .onSurfaceVariant,
                                    ),
                                  ),

                                  SizedBox(
                                    height:
                                        18.h,
                                  ),

                                  Container(
                                    width:
                                        36.w,
                                    height:
                                        36.h,

                                    decoration:
                                        BoxDecoration(
                                      color:
                                          Colors
                                              .green,

                                      borderRadius:
                                          BorderRadius.circular(
                                        6.r,
                                      ),
                                    ),

                                    child:
                                        const Icon(
                                      Icons.add,
                                      color:
                                          Colors
                                              .white,
                                    ),
                                  ),
                                ],
                              ),
                  ),
                );
              }),

              SizedBox(height: 30.h),

              /// Submit Button
              Center(
                child: SizedBox(
                  width: 140.w,
                  height: 46.h,

                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey
                          .currentState!
                          .validate()) {
                        return;
                      }

                      if (selectedImage
                              .value ==
                          null) {
                        CustomToast.error(
                          "Please upload receipt image",
                        );

                        return;
                      }

                      final bank =
                          controller
                              .selectedPlan
                              .value;

                      await controller
                          .createWalletRequest(
                        amount:
                            amountController
                                .text
                                .trim(),

                        paymenttype:
                            paymentType
                                .value,

                        utrno:
                            utrController
                                .text
                                .trim(),

                        bankid:
                            bank?.id
                                .toString() ??
                            "",

                        description:
                            descriptionController
                                .text
                                .trim(),

                        receipt:
                            receiptController
                                .text
                                .trim(),
                      );

                      controller.clearForm(
                        amountController:
                            amountController,

                        utrController:
                            utrController,

                        descriptionController:
                            descriptionController,

                        receiptController:
                            receiptController,

                        paymentType:
                            paymentType,

                        selectedImage:
                            selectedImage,
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF1CA3BA,
                      ),

                      elevation: 0,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          8.r,
                        ),
                      ),
                    ),

                    child: Text(
                      "Submit",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Label
  Widget buildLabel(
    BuildContext context,
    String text,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 6.h,
      ),

      child: Text(
        text,

        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,

          color:
              Theme.of(context)
                  .colorScheme
                  .onSurface,
        ),
      ),
    );
  }

  /// TextField
  Widget buildTextField({
    required BuildContext context,
    required TextEditingController
        controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,

      style: TextStyle(
        color:
            Theme.of(context)
                .colorScheme
                .onSurface,
      ),

      validator: (value) {
        if (value == null ||
            value.trim().isEmpty) {
          return "Please enter this field";
        }
        return null;
      },

      decoration: inputDecoration(
        context,
        hint,
      ),
    );
  }

  /// Input Decoration
  InputDecoration inputDecoration(
    BuildContext context,
    String hint,
  ) {
    final isDark = Get.isDarkMode;

    return InputDecoration(
      hintText: hint,

      hintStyle: TextStyle(
        color:
            Theme.of(context)
                .colorScheme
                .onSurfaceVariant,

        fontSize: 13.sp,
      ),

      filled: true,

      fillColor:
          isDark
              ? const Color(
                0xFF1E1E1E,
              )
              : const Color(
                0xFFF2F2F2,
              ),

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          8.r,
        ),

        borderSide: BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          8.r,
        ),

        borderSide: BorderSide.none,
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          8.r,
        ),

        borderSide: const BorderSide(
          color: Color(0xFF1CA3BA),
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          8.r,
        ),

        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      focusedErrorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          8.r,
        ),

        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }

  /// Pick Image
  Future<void> pickImage() async {
    final XFile? image =
        await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      selectedImage.value =
          File(image.path);

      receiptController.text =
          image.path;

      AppLogger.debugPrint(
        "Selected Image: ${image.path}",
      );
    }
  }
}