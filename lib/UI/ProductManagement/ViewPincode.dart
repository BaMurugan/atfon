import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class ViewPincode extends StatefulWidget {
  List? pincodes = [];
  ViewPincode({super.key, this.pincodes});

  @override
  State<ViewPincode> createState() => _ViewPincodeState();
}

class _ViewPincodeState extends State<ViewPincode> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showPopover(
          barrierColor: Colors.transparent,
          width: MediaQuery.of(context).size.width * 0.3,
          arrowHeight: 0,
          direction: PopoverDirection.bottom,
          context: context,
          height: MediaQuery.of(context).size.height * 0.15,
          radius: 0,
          bodyBuilder: (context) {
            return Scrollbar(
              trackVisibility: true,
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    widget.pincodes!.length,
                    (index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.pincodes?[index] ?? '00',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
      child: SizedBox(
        child: Text(
          "${widget.pincodes?.length} Pincodes",
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
