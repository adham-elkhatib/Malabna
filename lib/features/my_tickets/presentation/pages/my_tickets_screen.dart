// Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Data/Model/Match/match.model.dart';
import '../../../../Data/Model/booking/booking.model.dart';
import '../../../../Data/Repositories/booking_repo.dart';
import '../../../../Data/Repositories/match.repo.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../widgets/ticket_card.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({Key? key}) : super(key: key);

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  // State Variables
  String? userId;
  List<Booking?> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  // Initialize user ID and fetch bookings
  void _initializeState() async {
    userId = AuthService(
      authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
    ).getCurrentUserId();

    if (userId != null) {
      try {
        final fetchedBookings = await BookingRepo().readAllWhere(
          [
            QueryCondition.equals(
              field: "user_id",
              value: userId!,
            )
          ],
        );
        if (fetchedBookings != null) {
          setState(() {
            bookings = fetchedBookings;
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
        }
      } catch (e) {
        setState(() => isLoading = false);
        _showErrorSnackbar(
            "حدث خطأ أثناء تحميل التذاكر. حاول مرة أخرى لاحقًا.");
      }
    } else {
      setState(() => isLoading = false);
      _showErrorSnackbar("يرجى تسجيل الدخول لعرض التذاكر الخاصة بك.");
    }
  }

  // Display error messages using Snackbar
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Generate TicketCards asynchronously
  Future<List<Widget>> _generateTicketCards() async {
    List<Widget> ticketCards = [];

    for (var booking in bookings) {
      try {
        Match? match = await MatchesRepo().readSingle(booking!.matchId);
        if (match != null) {
          ticketCards.add(TicketCard(
            booking: booking,
            match: match,
          ));
        }
      } catch (e) {
        _showErrorSnackbar("حدث خطأ أثناء تحميل بيانات المباراة.");
      }
    }

    return ticketCards;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تذاكري"),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : bookings.isEmpty
                ? const Center(child: Text("لا يوجد تذاكر محجوزة"))
                : FutureBuilder<List<Widget>>(
                    future: _generateTicketCards(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("حدث خطأ أثناء تحميل التذاكر."),
                        );
                      } else if (snapshot.hasData) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: snapshot.data!),
                        );
                      } else {
                        return const Center(
                          child: Text("لا يوجد بيانات متاحة."),
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
