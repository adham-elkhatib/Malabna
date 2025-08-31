//t2 Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Data/Model/Restaurants/food_order_item_model.dart';
import '../../../../Data/Model/Restaurants/food_order_model.dart';
import '../../../../Data/Model/Restaurants/food_order_status_enum.dart';
import '../../../../Data/Model/Restaurants/item_model.dart';
import '../../../../Data/Model/Restaurants/restaurant_model.dart';
import '../../../../Data/Model/Restaurants/restaurants_status_enum.dart';
import '../../../../Data/Repositories/food_order_repo.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../../core/Services/Error Handling/error_handling.service.dart';
import '../../../../core/Services/Id%20Generating/id_generating.service.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../authentication/presentation/pages/sign_in.screen.dart';
import '../../../restaurants_orders/presentation/widgets/order_details_widget.dart';
import '../widgets/item_details_widget.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class RestaurantsDetailsScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Restaurant restaurant;

  //!SECTION
  //
  const RestaurantsDetailsScreen({
    Key? key,
    required this.restaurant,
  }) : super(
          key: key,
        );

  @override
  State<RestaurantsDetailsScreen> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantsDetailsScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers

  //t2 --Controllers
  //
  FoodOrder? currentFoodOrder;

  //t2 --State
  @override
  void initState() {
    fetchRestaurantOrders();
    super.initState();
  }

  fetchRestaurantOrders() async {
    String? userId = await AuthService(
      authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
    ).getCurrentUserId();
    if (userId != null) {
      FoodOrder? foodOrder = (await FoodOrderRepo().readAllWhere(
        [
          QueryCondition.equals(
            field: 'restaurant_id',
            value: widget.restaurant.id,
          ),
          QueryCondition.equals(
            field: 'status',
            value: FoodOrderStatus.pendingSend.index,
          ),
          QueryCondition.equals(field: 'user_id', value: userId),
        ],
        limit: 1,
      ))
          ?.firstOrNull;
      setState(() {
        currentFoodOrder = foodOrder;
      });
    }
  }

  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION
  //SECTION - Stateless functions
  //!SECTION
  void _onOrderDeleted(String orderId) {
    setState(() {
      currentFoodOrder = null;
    });
  }

  Future<void> postFoodOrder(Item item, int quantity) async {
    try {
      String? userId = await AuthService(
        authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
      ).getCurrentUserId();
      if (userId != null) {
        final String itemId = IdGeneratingService.generate();

        FoodOrderItem foodOrderItem = FoodOrderItem(
          id: itemId,
          quantity: quantity,
          item: item,
        );

        FoodOrder? foodOrder = (await FoodOrderRepo().readAllWhere(
          [
            QueryCondition.equals(
              field: 'restaurant_id',
              value: widget.restaurant.id,
            ),
            QueryCondition.equals(
              field: 'status',
              value: FoodOrderStatus.pendingSend.index,
            ),
            QueryCondition.equals(field: 'user_id', value: userId),
          ],
          limit: 1,
        ))
            ?.firstOrNull;

        if (foodOrder == null) {
          String foodOrderId = IdGeneratingService.generate(pattern: "6{d}");

          FoodOrder newFoodOrder = FoodOrder(
            id: foodOrderId,
            userId: userId,
            items: [foodOrderItem],
            date: DateTime.now(),
            restaurantId: widget.restaurant.id,
            status: FoodOrderStatus.pendingSend,
          );
          await FoodOrderRepo().createSingle(
            newFoodOrder,
            itemId: newFoodOrder.id,
          );
          setState(() {
            currentFoodOrder = newFoodOrder;
          });
        } else {
          FoodOrderItem? existingItem;

          try {
            existingItem = foodOrder.items.firstWhere(
              (orderItem) => orderItem.item.itemName == item.itemName,
            );
          } catch (e) {
            existingItem = null;
          }

          if (existingItem != null) {
            existingItem.quantity += quantity;
          } else {
            foodOrder.items.add(foodOrderItem);
          }

          await FoodOrderRepo().updateSingle(foodOrder.id, foodOrder);
          setState(() {
            currentFoodOrder = foodOrder;
          });
        }

        SnackbarHelper.showTemplated(context,
            title: "تم اضافة المنتج للسلة بنجاح!");
      } else {
        SnackbarHelper.showError(context,
            title: "يجب عليك تسجيل الدخول من اجل تاكيد طلب اوردر!");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const SignInScreen(),
          ),
          (route) => false,
        );
        return;
      }
    } catch (e) {
      ErrorHandlingService.error(
          e.toString(), "restaurant details screen/postFoodOrder");
    }
  }

  void _showItemDetails(Item item) {
    int quantity = 1;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ItemDetailsWidget(
          item: item,
          passedQuantity: quantity,
          postFoodOrder: postFoodOrder,
        );
      },
    );
  }

  //SECTION - Action Callbacks
  //!SECTION
  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    void showOrderDetails(FoodOrder foodOrder) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child: OrderDetailsWidget(
              showTimeline: false,
              foodOrder: foodOrder,
              refresh: () => _onOrderDeleted(
                foodOrder.id,
              ),
            ),
          );
        },
      );
    }
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.restaurant.restaurantNameAr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section with Overlay Status Ribbon
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.restaurant.logoUrl,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Ribbon for "Closed" Status
                  Positioned(
                    top: 16,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: widget.restaurant.status.color,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        widget.restaurant.status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Menu Items Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "قائمة الطعام",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),

              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.restaurant.items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final item = widget.restaurant.items[index];
                  final bool isRestaurantClosed =
                      widget.restaurant.status == RestaurantsStatus.closed;

                  return GestureDetector(
                    onTap: () {
                      if (!isRestaurantClosed) {
                        _showItemDetails(item);
                      }
                    },
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              item.imgUrl,
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Text(
                              item.itemName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "${item.price} ر.س",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: currentFoodOrder != null
            ? FloatingActionButton(
                onPressed: () => showOrderDetails(
                  currentFoodOrder!,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                elevation: 6.0,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : null,
      ),
    );
    //!SECTION
  }
}
