import 'package:autofon_seller/UI/HomePage/Home_Page.dart';
import 'package:autofon_seller/UI/ProfilePage/SellerType.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../UI/ProfilePage/EditProfile/EditProfilePage.dart';
import '../../Controller/Profile_Service.dart';
import 'AvailableSwitch.dart';
import 'EmailContainer.dart';
import 'RewardPoint.dart';
import 'WalletBalance.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileService = Get.put(ProfileService());
  Future<bool> willPop() async {
    Get.offAll(HomePage());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: willPop,
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await profileService.getProfileAddress();
                  Get.to(EditProfilePage());
                },
                child: Icon(FontAwesomeIcons.edit)),
            body: StreamBuilder<dynamic>(
              stream: profileService.instilize(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          "Please Try Again after Sometimes ${snapshot.error.toString()}"));
                }
                return GetBuilder<ProfileService>(
                  builder: (_) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileService.user.data?.user?.name ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  profileService.user.data?.user?.email ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 2))),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "User Details",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    AvailableSwitch()
                                  ])),
                          lineItems(
                              title: "Name",
                              data: Text(
                                  profileService.user.data?.user?.name ?? '')),
                          lineItems(
                              title: "Company Name",
                              data: Text(
                                  profileService.user.data?.companyName ?? '')),
                          lineItems(
                              title: "GST Number",
                              data: Text(profileService
                                      .profileAddress.data?[0].gstNumber ??
                                  'N/A')),
                          lineItems(
                              title: "PAN Number",
                              data: Text(profileService
                                      .profileAddress.data?[0].panNumber ??
                                  'N/A')),
                          lineItems(
                              title: "Seller Type",
                              data: SellerType(
                                action: () {
                                  setState(() {});
                                },
                              )),
                          lineItems(
                              title: "Approved Status",
                              data: Text(
                                  profileService.user.data?.approved ?? false
                                      ? 'Approved'
                                      : 'Not Approved',
                                  style: TextStyle(
                                      color:
                                          profileService.user.data?.approved ??
                                                  false
                                              ? Colors.green
                                              : Colors.red))),
                          lineItems(
                              title: 'Seller Point',
                              data: Text(
                                  '${profileService.user.data?.sellerPoints ?? '0'}')),
                          lineItems(
                              title: 'Referral Code',
                              data: Text(profileService
                                      .user.data?.user?.referralCode ??
                                  'N/A')),
                          RewardPoint(),
                          WalletBalance(),
                          lineItems(
                              title: 'GST Document ID',
                              data: profileService
                                          .profileAddress.data?[0].gstFileUrl !=
                                      null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                            '${profileService.profileAddress.data?[0].gstFileName}'),
                                        MaterialButton(
                                          onPressed: () async {
                                            try {
                                              await launchUrl(
                                                Uri.parse(profileService
                                                    .profileAddress
                                                    .data![0]
                                                    .gstFileUrl!),
                                                mode:
                                                    LaunchMode.inAppBrowserView,
                                              );
                                            } catch (e) {
                                              Get.snackbar('Error',
                                                  'Unable to Download');
                                            }
                                          },
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          child: Text(
                                            "Download",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        )
                                      ],
                                    )
                                  : Text('--')),
                          lineItems(
                              title: 'PAN Document ID',
                              data: profileService
                                          .profileAddress.data?[0].panFileUrl !=
                                      null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                            '${profileService.profileAddress.data?[0].panFileName}'),
                                        MaterialButton(
                                          onPressed: () async {
                                            try {
                                              await launchUrl(
                                                Uri.parse(profileService
                                                    .profileAddress
                                                    .data![0]
                                                    .panFileUrl!),
                                                mode:
                                                    LaunchMode.inAppBrowserView,
                                              );
                                            } catch (e) {
                                              Get.snackbar('Error',
                                                  'Unable to Download');
                                            }
                                          },
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          child: Text(
                                            "Download",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        )
                                      ],
                                    )
                                  : Text('--')),
                          SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 2))),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Contact Details",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          EmailContainer(action: () {
                            setState(() {});
                          }),
                          contactItems('Phone Number',
                              profileService.user.data?.user?.phone ?? 'N/A'),
                          contactItems('Alternate Phone',
                              '${(profileService.user.data?.alternatePhoneOne?.trim().isNotEmpty ?? false) ? profileService.user.data?.alternatePhoneOne : '--'}, ${(profileService.user.data?.alternatePhoneTwo?.trim().isNotEmpty ?? false) ? profileService.user.data?.alternatePhoneTwo : '--'}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  contactItems(String key, String value) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              Icon(FontAwesomeIcons.phone),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [Text(key), Text(value)])
            ]));
  }

  lineItems({required String title, required Widget data}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(children: [
          Expanded(
            child: Text(title),
          ),
          Expanded(
            child: data,
          )
        ]));
  }
}
