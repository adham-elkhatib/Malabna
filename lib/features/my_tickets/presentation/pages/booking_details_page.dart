//t2 Core Packages Imports
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as date;
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../Data/Model/Match/match.model.dart';
import '../../../../Data/Model/booking/booking.model.dart';
import '../../../../Data/Repositories/match.repo.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../core/widgets/info_widget.dart';
import '../../../../core/widgets/section_title.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class BookingDetailsPage extends StatefulWidget {
  // SECTION - Widget Arguments
  final Booking booking;

  //!SECTION
  //
  const BookingDetailsPage({super.key, required this.booking});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool isLoading = true;
  Match? match;

  @override
  void initState() {
    MatchesRepo().readSingle(widget.booking.matchId).then((fetchedMatch) {
      if (fetchedMatch != null) {
        setState(() {
          match = fetchedMatch;
          isLoading = false;
        });
      } else {
        SnackbarHelper.showError(
          context,
          title: "خطأ في تحميل المباراة",
          message:
              "تعذر استرداد تفاصيل المباراة. يرجى المحاولة مرة أخرى لاحقًا.",
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل الحجز'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : match != null
                ? SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(
                            title: 'تفاصيل المباراة',
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: QrImageView(
                              data: widget.booking.qrCode,
                              version: QrVersions.auto,
                              gapless: false,
                            ),
                          ),
                          const SizedBox(height: 8),
                          BuildInfoRow(
                            label: "المباراه",
                            value: "${match?.firstTeam} X ${match?.secondTeam}",
                          ),
                          BuildInfoRow(
                            label: "تاريخ المباراه",
                            value: date.DateFormat('dd-MM-yyy')
                                .format(match!.dateTime),
                          ),
                          BuildInfoRow(
                            label: "موعد بدء المباراه",
                            value: date.DateFormat('hh:mm')
                                .format(match!.dateTime),
                          ),
                          const Divider(height: 20),
                          const SectionTitle(
                            title: 'المقاعد المحجوزة',
                          ),
                          BuildInfoRow(
                            label: "اسم الفئة:",
                            value: widget.booking.ticketCategory,
                          ),
                          ...widget.booking.bookedSeats.map((seat) =>
                              BuildInfoRow(
                                  label: "المقعد رقم:",
                                  value: '${seat.number}')),
                          BuildInfoRow(
                            label: "إجمالي السعر:",
                            value: ' ${widget.booking.totalPrice} ر.س',
                          ),
                          const Divider(height: 20),
                          if (widget.booking.parkingReservation != null) ...[
                            Text(
                              'تفاصيل حجز موقف السيارة',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: QrImageView(
                                data: widget.booking.parkingReservation!.qrCode,
                                version: QrVersions.auto,
                                gapless: false,
                              ),
                            ),
                            BuildInfoRow(
                              label: "صالح يوم:",
                              value: date.DateFormat('dd-MM-yyyy').format(
                                  widget.booking.parkingReservation!.validDate),
                            ),
                            SizedBox(
                              height: 400,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: widget.booking.parkingReservation!
                                      .parkingZone.location,
                                  zoom: 15,
                                ),
                                markers: {
                                  Marker(
                                    markerId: const MarkerId("موقف الموقف"),
                                    position: widget.booking.parkingReservation!
                                        .parkingZone.location,
                                    infoWindow: const InfoWindow(
                                        title: "موقع الموقف هنا"),
                                  ),
                                },
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      "تعذر استرداد تفاصيل المباراة. يرجى المحاولة مرة أخرى لاحقًا.",
                    ),
                  ),
      ),
    );
    //!SECTION
  }
}
