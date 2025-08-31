//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date;

import '../../../../Data/Model/Match/match.model.dart';
import '../../../../core/widgets/info_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../booking/presentation/pages/booking_screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class MatchDetailsScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Match match;

  //!SECTION
  //
  const MatchDetailsScreen({
    super.key,
    required this.match,
  });

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
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

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    //t2 --Controllers & Listeners
    //
    //t2 --State
    //t2 --State
    //
    //t2 --Late & Async Initializers
    //t2 --Late & Async Initializers
    //!SECTION
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --State
    //t2 --State
    //!SECTION
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
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تفاصيل المباراه"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(widget.match.imageUrl)),
                const SizedBox(
                  height: 16,
                ),
                BuildInfoRow(
                  label: "اسم المباراه",
                  value:
                      "${widget.match.firstTeam} X ${widget.match.secondTeam}",
                ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(),
                BuildInfoRow(
                  label: "تاريخ المباراه",
                  value: date.DateFormat('dd-MM-yyyy')
                      .format(widget.match.dateTime),
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                BuildInfoRow(
                  label: "الوصف",
                  value: widget.match.matchDescription,
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                BuildInfoRow(
                  label: "موعد بدء المباراه",
                  value: date.DateFormat('hh:mm').format(widget.match.dateTime),
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                const BuildInfoRow(
                  label: "سعر التذكرة",
                  value: "يبدأ من 150 ريال",
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: PrimaryButton(
              title: "احجز تذكرتك!",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => BookingScreen(
                      match: widget.match,
                    ),
                  ),
                );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute<void>(
                //     builder: (BuildContext context) => BookingScreen(
                //       match: widget.match,
                //     ),
                //   ),
                // );
              }),
        ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}
