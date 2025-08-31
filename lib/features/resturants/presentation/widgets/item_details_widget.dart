//t2 Core Packages Imports
import 'package:flutter/material.dart';

import '../../../../Data/Model/Restaurants/item_model.dart';
import '../../../../core/widgets/primary_button.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class ItemDetailsWidget extends StatefulWidget {
  // SECTION - Widget Arguments
  final int passedQuantity;
  final Item item;
  final Function(Item, int) postFoodOrder;

  //!SECTION
  //
  const ItemDetailsWidget(
      {super.key,
      required this.passedQuantity,
      required this.item,
      required this.postFoodOrder});

  @override
  State<ItemDetailsWidget> createState() => _ItemDetailsWidgetState();
}

class _ItemDetailsWidgetState extends State<ItemDetailsWidget> {
  int quantity = 0;

  @override
  void initState() {
    quantity = widget.passedQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SECTION - Build Setup
    // Values
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    // Widgets
    //

    // Widgets
    //!SECTION

    // SECTION - Build Return
    return Directionality(
      textDirection: TextDirection.rtl,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.itemName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.item.itemDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$quantity',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    PrimaryButton(
                      title: "إضافة للسلة",
                      onPressed: () async {
                        await widget.postFoodOrder(widget.item, quantity);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    //!SECTION
  }
}
