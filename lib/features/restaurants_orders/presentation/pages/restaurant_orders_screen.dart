//t2 Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date;

import '../../../../Data/Model/Restaurants/food_order_model.dart';
import '../../../../Data/Model/Restaurants/food_order_status_enum.dart';
import '../../../../Data/Repositories/food_order_repo.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../widgets/order_details_widget.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class RestaurantOrdersScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const RestaurantOrdersScreen({
    super.key,
  });

  @override
  State<RestaurantOrdersScreen> createState() => _RestaurantOrdersScreenState();
}

class _RestaurantOrdersScreenState extends State<RestaurantOrdersScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  //t2 --Controllers
  //
  //t2 --State
  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION
  List<FoodOrder?> foodOrders = [];
  List<FoodOrder?> filteredOrders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFoodOrders();
  }

// Function to fetch food orders from Firestore
  Future<void> _fetchFoodOrders() async {
    try {
      String? userId = AuthService(
        authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
      ).getCurrentUserId();
      if (userId != null) {
        var orders = await FoodOrderRepo().readAllWhere(
          [
            QueryCondition.equals(
              field: 'user_id',
              value: userId,
            ),
          ],
        );

        foodOrders =
            (orders ?? []).cast<FoodOrder>(); // Cast orders to List<FoodOrder>

        filteredOrders = foodOrders
            .where((order) => order?.status != FoodOrderStatus.pendingSend)
            .toList();

        filteredOrders.sort((a, b) => a!.date.compareTo(b!.date));

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching food orders: $e");
    }
  }

  //SECTION - Stateless functions
  //!SECTION

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
              showTimeline: true,
              foodOrder: foodOrder,
              refresh: () {
                setState(() {});
              },
            ),
          );
        },
      );
    }

    Widget buildOrderCard(FoodOrder foodOrder) {
      return GestureDetector(
        onTap: () => showOrderDetails(foodOrder),
        child: Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 4.0,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              "طلب: ${foodOrder.id}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("المطعم: ${foodOrder.restaurant.restaurantNameAr}"),
                Text(
                  "تاريخ الطلب: ${date.DateFormat('dd-MM-yyyy').format(foodOrder.date)}",
                ),
                Text("الحالة: ${foodOrder.status.name}"),
                Text("الأجمالي: ${foodOrder.calculateTotalPrice()} ر.س"),
              ],
            ),
            trailing: const Icon(Icons.more_horiz),
          ),
        ),
      );
    }

    //t2 -Widgets
    //!SECTION
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("طلباتي"),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : foodOrders.isEmpty
                ? const Center(child: Text("لا يوجد لديك طلبات سابقة!"))
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          final foodOrder = filteredOrders[index];
                          return buildOrderCard(foodOrder!);
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
