import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../../Data/Model/Restaurants/food_order_model.dart';
import '../../../../Data/Model/Restaurants/food_order_status_enum.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class TimelineWidget extends StatelessWidget {
  // SECTION - Widget Arguments
  final FoodOrder foodOrder;

  //!SECTION
  //
  const TimelineWidget({super.key, required this.foodOrder});

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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 80,
        maxHeight: 120,
      ),
      child: Timeline.tileBuilder(
        scrollDirection: Axis.horizontal,
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          connectorBuilder: (context, index, type) {
            final isActive =
                foodOrder.status.index >= FoodOrderStatus.values[index].index;

            return SolidLineConnector(
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              thickness: 3, // Adjust thickness as per design
            );
          },
          indicatorBuilder: (context, index) {
            final status = FoodOrderStatus.values[index];
            final isActive = foodOrder.status.index >= status.index;
            final isCurrent = foodOrder.status == status;

            return DotIndicator(
              size: isCurrent ? 24 : 18,
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              child: isCurrent
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            );
          },
          itemExtentBuilder: (context, index) => 100,
          contentsBuilder: (context, index) {
            final status = FoodOrderStatus.values[index];

            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                status.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: foodOrder.status.index >= status.index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            );
          },
          itemCount: FoodOrderStatus.values.length,
        ),
      ),
    );
    //!SECTION
  }
}
