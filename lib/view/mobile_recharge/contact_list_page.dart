import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactListPage extends StatefulWidget {
  final TextEditingController mobileController;
  final List<Contact> contacts;

  const ContactListPage({
    super.key,
    required this.mobileController,
    required this.contacts,
  });

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final TextEditingController searchController =
      TextEditingController();

  late List<Contact> filteredContacts;

  @override
  void initState() {
    super.initState();
    filteredContacts = widget.contacts;
  }

void searchContacts(String value) {
  final query = value.toLowerCase().trim();

  setState(() {
   filteredContacts = widget.contacts.where((contact) {
  print(contact.displayName);

  final name = (contact.displayName ?? '')
      .toLowerCase()
      .trim();

  return name.contains(query);
}).toList();
  });
}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
titleSpacing: 0,

      centerTitle: false,

     
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color:
                isDark
                    ? Colors.white
                    : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        

        title: Padding(
  padding: EdgeInsets.only(right: 12.w),
  child: Container(
    height: 44.h,
    width: double.infinity,
    decoration: BoxDecoration(
      color: isDark ? Colors.grey.shade900 : Colors.white,
      borderRadius: BorderRadius.circular(25.r),
      border: Border.all(
        color: isDark ? Colors.white24 : Colors.grey.shade400,
      ),
    ),

    child: TextField(
      controller: searchController,
      onChanged: searchContacts,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: "Search contacts",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.sp,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: 20.sp,
          color: isDark ? Colors.white70 : Colors.black54,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 7.h),
      ),
    ),
  ),
),
      ),

      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Padding(
            padding: EdgeInsets.all(16.w),

            child: Text(
              "All contacts",
              style: TextStyle(
                color:
                    isDark
                        ? Colors.white
                        : Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount:
                  filteredContacts.length,

              itemBuilder: (
                context,
                index,
              ) {
                final contact =
                    filteredContacts[index];
final name = (contact.displayName ?? '').trim();
        

                final phone =
                    contact.phones.isNotEmpty
                        ? contact
                            .phones
                            .first
                            .number
                        : "";

                return InkWell(
                  onTap: () {
  if (phone.isNotEmpty) {
    String cleanNumber = phone.replaceAll(RegExp(r'\D'), '');

    // Remove +91 / 91 if present
    if (cleanNumber.startsWith('91') &&
        cleanNumber.length > 10) {
      cleanNumber = cleanNumber.substring(
        cleanNumber.length - 10,
      );
    }

    widget.mobileController.text = cleanNumber;

    Navigator.pop(context);
  }
},

                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),

                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,

                          backgroundColor:
                              Colors.primaries[
                                  index %
                                      Colors
                                          .primaries
                                          .length],

                          child: Text(
                            name.isNotEmpty
                                ? name[0]
                                    .toUpperCase()
                                : "?",
                            style: TextStyle(
                              color:
                                  Colors.white,
                              fontSize: 22.sp,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(width: 16.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [
                              Text(
                                name.isNotEmpty
                                    ? name
                                    : "No Name",

                                style: TextStyle(
                                  color:
                                      isDark
                                          ? Colors
                                              .white
                                          : Colors
                                              .black,
                                  fontSize:
                                      16.sp,
                                  fontWeight:
                                      FontWeight
                                          .w500,
                                ),
                              ),

                              SizedBox(
                                  height: 4.h),

                              Text(
                                phone,

                                style: TextStyle(
                                  color:
                                      isDark
                                          ? Colors
                                              .white70
                                          : Colors
                                              .black54,
                                  fontSize:
                                      14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}