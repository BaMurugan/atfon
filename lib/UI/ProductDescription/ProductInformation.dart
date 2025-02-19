import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/ProductDescription_Service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductInformation extends StatefulWidget {
  const ProductInformation({super.key});

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  final controller = Get.find<ProductDescriptionService>();

  @override
  Widget build(BuildContext context) {
    products({bool size = true}) {
      ScrollController scrollController = ScrollController();
      List<String?> uniqueSizes = controller
          .productDescriptionModule.data!.variant!.variantProducts!
          .map((product) => size ? product.size : product.subtype)
          .where((item) => item != null && item.isNotEmpty)
          .toSet()
          .toList();

      final selectedProduct = size
          ? controller.productDescriptionModule.data!.size
          : controller.productDescriptionModule.data!.subtype;

      uniqueSizes.sort((a, b) {
        if (a == selectedProduct) return -1;
        if (b == selectedProduct) return 1;
        return 0;
      });
      if (uniqueSizes.isEmpty) {
        return SizedBox();
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          controller: scrollController,
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              uniqueSizes.length,
              (index) {
                final product = controller
                    .productDescriptionModule.data!.variant!.variantProducts!
                    .firstWhere(
                  (prod) =>
                      (size ? prod.size : prod.subtype) == uniqueSizes[index],
                );
                bool type = size
                    ? (product.size ==
                        controller.productDescriptionModule.data!.size)
                    : (product.subtype ==
                        controller.productDescriptionModule.data!.subtype);
                return GestureDetector(
                  onTap: () {
                    controller.getData(product.id!);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: type
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.white,
                      border: Border.all(),
                    ),
                    child: Text(
                      size ? '${product.size}' : '${product.subtype}',
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    lineItem(String type, String data) {
      return Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(type, style: Theme.of(context).textTheme.labelMedium),
          Text(data, style: Theme.of(context).textTheme.labelSmall),
        ],
      );
    }

    return GetBuilder<ProductDescriptionService>(
      builder: (_) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(
                  controller.productDescriptionModule.data!.imageUrl!,
                ),
              ),
              Text(controller.productDescriptionModule.data!.name!,
                  textAlign: TextAlign.center),
              Text(
                  '${controller.productDescriptionModule.data?.variant?.variantType ?? ''} \t ${controller.productDescriptionModule.data?.size ?? ""}'),
              products(),
              Text(
                  '${controller.productDescriptionModule.data?.variant?.subvariantType ?? ""} \t ${controller.productDescriptionModule.data!.subtype ?? ''}'),
              products(size: false),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Brouchure'),
                  MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () async {
                      try {
                        await launchUrl(
                          Uri.parse(controller
                              .productDescriptionModule.data!.brouchureOrSpec!),
                          mode: LaunchMode.inAppBrowserView,
                        );
                      } catch (e) {
                        Get.snackbar('Error', 'Unable to Download');
                      }
                    },
                    child: Text('Download',
                        style: Theme.of(context).textTheme.labelSmall),
                  )
                ],
              ),
              lineItem('Return Policy',
                  controller.productDescriptionModule.data?.returnPolicy ?? ""),
              Text('Product Details',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.left),
              lineItem('Description',
                  controller.productDescriptionModule.data?.description ?? ""),
              lineItem(
                  'Manufacturer',
                  controller
                          .productDescriptionModule.data?.manufacturer?.name ??
                      ""),
              ...List.generate(
                controller
                    .productDescriptionModule.data!.productSpec!.spec!.length,
                (index) {
                  return lineItem(
                      controller.productDescriptionModule.data!.productSpec!
                          .spec![index].field!,
                      controller.productDescriptionModule.data!.productSpec!
                              .spec?[index].value ??
                          "");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
