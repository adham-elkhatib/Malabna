//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date;

import '../../../../Data/Model/Restaurants/food_order_model.dart';
import '../../../../Data/Model/Restaurants/food_order_status_enum.dart';
import '../../../../Data/Model/Restaurants/restaurant_model.dart';
import '../../../../Data/Repositories/food_order_repo.dart';
import '../../../../Data/Repositories/resturant_repo.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../core/widgets/primary_button.dart';
import 'timeline_widget.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class OrderDetailsWidget extends StatefulWidget {
  // SECTION - Widget Arguments
  final FoodOrder foodOrder;
  final void Function() refresh;
  final bool showTimeline;

  //!SECTION
  //
  const OrderDetailsWidget(
      {super.key,
      required this.foodOrder,
      required this.refresh,
      required this.showTimeline});

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  bool isLoading = true;
  Restaurant? restaurant;

  @override
  void initState() {
    RestaurantRepo()
        .readSingle(widget.foodOrder.restaurantId)
        .then((fetchedRestaurant) {
      if (fetchedRestaurant != null) {
        setState(() {
          restaurant = fetchedRestaurant;
          isLoading = false;
        });
      } else {
        SnackbarHelper.showError(
          context,
          title: "خطأ في تحميل المطعم",
          message: "تعذر استرداد تفاصيل المطعم. يرجى المحاولة مرة أخرى لاحقًا.",
        );
        isLoading = false;
      }
    });
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : restaurant != null
            ? Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.showTimeline
                          ? TimelineWidget(
                              foodOrder: widget.foodOrder,
                            )
                          : Container(),
                      Text(
                        "تفاصيل الطلب - ${widget.foodOrder.id}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8.0),
                      Text("المطعم: ${restaurant!.restaurantNameAr}"),
                      const SizedBox(height: 8.0),
                      Text(
                        "تاريخ الطلب: ${date.DateFormat('dd-MM-yyyy').format(widget.foodOrder.date)}",
                      ),
                      const SizedBox(height: 8.0),
                      Text("الحالة: ${widget.foodOrder.status.name}"),
                      const SizedBox(height: 8.0),
                      Text(
                          "الأجمالي: ${widget.foodOrder.calculateTotalPrice()} ر.س"),
                      const SizedBox(height: 16.0),
                      Text("المنتجات:",
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ListView(
                          children: widget.foodOrder.items.map((item) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6.0,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      item.item.imgUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                            Icons.image_not_supported,
                                            size: 60);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.item.itemName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("الكمية: ${item.quantity}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Text(
                                    "${item.item.price * item.quantity} ر.س",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      if (widget.foodOrder.status ==
                          FoodOrderStatus.pendingSend)
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                title: "أرسال الطلب",
                                onPressed: () async {
                                  bool? confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("تأكيد الطلب"),
                                        content: const Text(
                                            "هل أنت متأكد أنك تريد إرسال الطلب؟"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text("لا"),
                                          ),
                                          PrimaryButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            title: "نعم",
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (confirm == true) {
                                    widget.foodOrder.status =
                                        FoodOrderStatus.pendingApproval;
                                    await FoodOrderRepo().updateSingle(
                                        widget.foodOrder.id, widget.foodOrder);
                                    Navigator.pop(context);
                                    SnackbarHelper.showTemplated(
                                      context,
                                      title: "تم ارسال الطلب بنجاح",
                                    );
                                  } else {
                                    SnackbarHelper.showError(
                                      context,
                                      title: "تم إلغاء الطلب",
                                    );
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () async {
                                  await FoodOrderRepo()
                                      .deleteSingle(widget.foodOrder.id);
                                  SnackbarHelper.showError(context,
                                      title: "تم حذف الطلب بنجاح");
                                  Navigator.pop(context);
                                  widget.refresh();
                                },
                                style: ButtonStyle(
                                  foregroundColor: WidgetStatePropertyAll(
                                      Theme.of(context).colorScheme.error),
                                ),
                                child: const Text(
                                  "الغاء الطلب",
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: Text(
                  "تعذر استرداد تفاصيل المطعم. يرجى المحاولة مرة أخرى لاحقًا.",
                ),
              );

    //!SECTION
  }
}
