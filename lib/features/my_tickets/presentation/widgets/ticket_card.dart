//t2 Core Packages Imports
import 'package:flutter/material.dart';

import '../../../../Data/Model/Match/match.model.dart';
import '../../../../Data/Model/booking/booking.model.dart';
import '../pages/booking_details_page.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class TicketCard extends StatefulWidget {
  // SECTION - Widget Arguments
  final Booking booking;
  final Match match;

  //!SECTION
  //
  const TicketCard({super.key, required this.booking, required this.match});

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                BookingDetailsPage(booking: widget.booking),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          title: Text(
            '${widget.match.firstTeam} vs ${widget.match.secondTeam}',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          trailing: Text(
            '${widget.booking.totalPrice} ر.س',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
    //!SECTION
  }
}
