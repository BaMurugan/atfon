import 'package:flutter/material.dart';

class ProductListDesign extends StatefulWidget {
  dynamic itemData;
  ProductListDesign({super.key, required this.itemData});

  @override
  State<ProductListDesign> createState() => _ProductListDesignState();
}

class _ProductListDesignState extends State<ProductListDesign> {
  @override
  Widget build(BuildContext context) {
    dynamic itemData = widget.itemData;
    double quantity = double.tryParse('${itemData.units}' ?? '0.00') ?? 0.0;
    String formattedQuantity = quantity == quantity.toInt()
        ? quantity.toInt().toString()
        : quantity.toStringAsFixed(8).replaceAll(RegExp(r"([.]*0+)$"), "");
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            spacing: 5,
            children: [
              Image(
                image: NetworkImage(itemData.imageUrl),
                width: 50,
                height: 50,
              ),
              Expanded(child: Text(itemData.name))
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              columnItem('Quantity', '${formattedQuantity} ${itemData.uom}'),
              columnItem('Total Price',
                  'Rs. ${double.tryParse('${itemData?.itemTotalPrice ?? '0.00'}')?.toStringAsFixed(2)}'),
            ],
          )
        ],
      ),
    );
  }

  columnItem(dynamic key, dynamic value) {
    return Column(
      children: [
        Text('$key'),
        Text('$value'),
      ],
    );
  }
}
