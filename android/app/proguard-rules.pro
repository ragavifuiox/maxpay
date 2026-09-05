# Worldline / Weipl rules to ignore missing dependencies
-dontwarn com.nsdl.egov.esignaar.**
-dontwarn com.weipl.checkout.**

# Keep the Worldline package intact
-keep class com.weipl.checkout.** { *; }
-keep class com.worldline.in.weipl_checkout_flutter.** { *; }
