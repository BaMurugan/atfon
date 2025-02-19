import "package:autofon_seller/Authorization/Login/LoginPage.dart";
import "package:autofon_seller/Controller/DeleteAccount_Service.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:get/get_core/src/get_main.dart";
import "package:google_fonts/google_fonts.dart";

import "Others_constants.dart";

class OthersPage extends StatefulWidget {
  const OthersPage({super.key});

  @override
  State<OthersPage> createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  final deleteAccount = Get.put(DeleteAccountService());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<DeleteAccountService>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          const Text(
                            "Delete My Account",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(OtherConstants.othersData)
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        bool eye = true;
                        deleteAccount.errorMsg = null;
                        deleteAccount.update();
                        TextEditingController password =
                            TextEditingController();
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return GetBuilder<DeleteAccountService>(
                              builder: (_) {
                                return StatefulBuilder(
                                  builder: (context, setState) => Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        spacing: 10,
                                        children: [
                                          Text('Confirm Account Deletion',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                          Text(
                                              'Please enter your password to confirm the deletion of your account.'),
                                          Form(
                                              key: formKey,
                                              child: TextFormField(
                                                controller: password,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                obscureText: eye,
                                                decoration: InputDecoration(
                                                    labelText:
                                                        'Please Enter the Password',
                                                    labelStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                          eye = !eye;
                                                          deleteAccount
                                                              .update();
                                                        },
                                                        icon: Icon(eye
                                                            ? FontAwesomeIcons
                                                                .eye
                                                            : FontAwesomeIcons
                                                                .eyeSlash)),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 3.5))),
                                                validator: (value) {
                                                  if (value!.trim().isEmpty) {
                                                    return 'Please Enter the Password';
                                                  }
                                                  if (value.trim().length < 6) {
                                                    return 'Please Enter the Valid Password';
                                                  }
                                                  if (value.trim().length >
                                                      12) {
                                                    return 'Please Enter the Valid Password';
                                                  }
                                                  return null;
                                                },
                                              )),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              spacing: 10,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  child: Text('Cancel'),
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                ),
                                                InkWell(
                                                  child: Text(
                                                    'Delete Account',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    deleteAccount.errorMsg =
                                                        null;
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      bool result =
                                                          await deleteAccount
                                                              .deleteAccount(
                                                                  password
                                                                      .text);
                                                      if (result) {
                                                        Get.snackbar('Success',
                                                            'Account Deleted Successfully');
                                                        Get.back();
                                                        Get.offAll(LoginPage());
                                                      }
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                        await Future.delayed(Duration(seconds: 1));
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        "Delete My Account",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
