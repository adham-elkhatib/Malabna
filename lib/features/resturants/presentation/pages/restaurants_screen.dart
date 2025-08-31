//t2 Core Packages Imports
import 'package:flutter/material.dart';

import '../../../../Data/Model/Restaurants/restaurant_model.dart';
import '../../../../Data/Model/Restaurants/restaurant_type_enum.dart';
import '../../../../Data/Repositories/resturant_repo.dart';
import '../widgets/resturant_card.dart';
import 'restaurant_details_screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class RestaurantsScreen extends StatefulWidget {
  //SECTION - Widget Arguments

  //!SECTION
  //
  const RestaurantsScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<RestaurantsScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<RestaurantsScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  RestaurantType? selectedType = RestaurantType.all;
  late List<Restaurant?> restaurants;
  List<Restaurant?> filteredRestaurants = [];
  String searchText = "";
  bool isLoaded = false;

  //t2 --Controllers
  //
  //t2 --State
  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION
  //SECTION - Stateless functions
  //!SECTION
  @override
  void initState() {
    RestaurantRepo().readAll().then((value) {
      if (value != null) {
        setState(() {
          restaurants = value;
          filteredRestaurants = value;
          isLoaded = true;
        });
      }
    });
    super.initState();
  }

  void filterRestaurants(String query) {
    setState(() {
      searchText = query;
      if (query.isEmpty) {
        filteredRestaurants = restaurants;
      } else {
        filteredRestaurants = restaurants.where((restaurant) {
          return restaurant!.restaurantNameAr
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              restaurant.restaurantNameEn
                  .toLowerCase()
                  .contains(query.toLowerCase());
        }).toList();
      }
    });
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
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("المطاعم"),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: filterRestaurants,
                decoration: InputDecoration(
                  hintText: 'بحث عن مطعم...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: isLoaded
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: RestaurantType.values.map((type) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(type.displayName),
                            selected: selectedType == type,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedType = selected ? type : null;
                                if (selectedType == RestaurantType.all) {
                                  filteredRestaurants = restaurants;
                                } else {
                                  filteredRestaurants = restaurants
                                      .where((restaurant) =>
                                          restaurant?.restaurantType ==
                                          selectedType)
                                      .toList();
                                }
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: filteredRestaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = filteredRestaurants[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      RestaurantsDetailsScreen(
                                          restaurant: restaurant),
                                ),
                              );
                            },
                            child: RestaurantCard(
                              restaurant: restaurant!,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
    //!SECTION
  }
}
