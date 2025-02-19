import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: const Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                    "If you have any issues, questions, or inquiries, please feel free to contact our support team:"),
                InkWell(
                  onTap: () async {
                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: "support@autofon.com",
                      query:
                          '', // Optional
                    );

                    if (await canLaunchUrl(emailUri)) {
                      await launchUrl(emailUri);
                    } else {
                      throw 'Could not launch $emailUri';
                    }
                  },
                  child: ListTile(
                    style: ListTileStyle.list,
                    leading: Icon(
                      FontAwesomeIcons.solidEnvelope,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      "support@autofon.com",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse("tel:+919965166400");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.phone,
                      color: Colors.green,
                    ),
                    title: Text(
                      "+919965166400",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
