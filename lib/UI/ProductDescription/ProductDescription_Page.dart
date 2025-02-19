import 'package:autofon_seller/UI/ProductDescription/ProductInformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/ProductDescription_Service.dart';

class ProductDescriptionPage extends StatefulWidget {
  String id;
  ProductDescriptionPage({super.key, required this.id});

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  final productDescriptionController = Get.put(ProductDescriptionService());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: productDescriptionController.instilize(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('Something Went Wrong Please Try Again'));
            }
            return Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: ProductInformation());
          },
        ),
      ),
    );
  }
}
