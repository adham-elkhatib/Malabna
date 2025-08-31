//t2 Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import '../../../../Data/Model/Match/match.model.dart';
import '../../../../Data/Model/Parking/parking_reservation.dart';
import '../../../../Data/Model/Parking/parking_zone_model.dart';
import '../../../../Data/Model/booking/booking.model.dart';
import '../../../../Data/Model/seat/seat.model.dart';
import '../../../../Data/Model/seat_classification/seat_classification_model.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../../core/Services/Id%20Generating/id_generating.service.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../authentication/presentation/pages/sign_in.screen.dart';
import 'booking_summary_page.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class BookingScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Match match;

  //!SECTION
  //
  const BookingScreen({
    super.key,
    required this.match,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  //t2 --Controllers
  //
  //t2 --State
  SeatClassification? selectedSection;
  List<Seat> selectedSeats = [];
  bool canReserveParking = false;
  bool bookParking = false;
  MultiSelectController<Seat>? multiSelectController = MultiSelectController();

  //t2 --State
  //
  //t2 --Constants
  final _formKey = GlobalKey<FormState>();

  //t2 --Constants

  //!SECTION
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
          title: const Text("أحجز تذكرتك!"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset("assets/images/playground.png"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Dropdown for selecting a section
                      Expanded(
                        child: DropdownButtonFormField<SeatClassification>(
                          value: selectedSection,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "اختار المنطقة",
                            labelText: "المنطقة",
                          ),
                          validator: (value) {
                            if (value == null || selectedSection == null) {
                              return "الرجاء اختيار المنطقة";
                            }
                            return null;
                          },
                          items: widget.match.seatClassifications
                              .map<DropdownMenuItem<SeatClassification>>(
                                  (SeatClassification? section) {
                            return DropdownMenuItem<SeatClassification>(
                              value: section,
                              child: Text(section?.name ?? ""),
                            );
                          }).toList(),
                          onChanged: (SeatClassification? value) {
                            setState(() {
                              selectedSeats = [];
                              selectedSection = value;

                              List<DropdownItem<Seat>> dropdownItems =
                                  selectedSection!.seats
                                      .where((seat) => seat.isAvailable)
                                      .map(
                                (Seat seat) {
                                  return DropdownItem<Seat>(
                                    value: seat,
                                    label: "${seat.number}",
                                  );
                                },
                              ).toList();

                              multiSelectController?.setItems(dropdownItems);
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (selectedSection != null)
                        IconButton(
                          icon: const Icon(Icons.info, color: Colors.blue),
                          onPressed: selectedSection == null
                              ? null
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "اسم المنطقة: ${selectedSection?.name ?? "غير متوفر"}",
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "اسم الفئة: ${selectedSection?.sections[0] ?? "غير متوفر"}",
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "المقاعد المتاحة: ${selectedSection?.seats.where((seat) => seat.isAvailable).length ?? 0}",
                                              ),
                                              const SizedBox(height: 16),
                                              if (selectedSection?.imageUrl !=
                                                  null)
                                                Image.network(
                                                  selectedSection!.imageUrl,
                                                  fit: BoxFit.cover,
                                                  height: 150,
                                                )
                                              else
                                                const Text(
                                                    "لا توجد صورة لهذه المنطقة"),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("إغلاق"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MultiDropdown<Seat>(
                    items: selectedSection?.seats
                            .where((seat) => seat.isAvailable)
                            .map<DropdownItem<Seat>>((Seat seat) {
                          return DropdownItem<Seat>(
                            value: seat,
                            label: "${seat.number}",
                          );
                        }).toList() ??
                        [],
                    fieldDecoration: FieldDecoration(
                      border: const OutlineInputBorder(),
                      hintText: selectedSection == null
                          ? "اختار المقاعد"
                          : (selectedSection!.seats
                                  .where((seat) => seat.isAvailable)
                                  .isEmpty
                              ? "نفذت التذاكر!"
                              : "اختار المقاعد"),
                    ),
                    enabled: selectedSection != null &&
                        (selectedSection?.seats
                                .any((seat) => seat.isAvailable) ??
                            false),
                    controller: multiSelectController,
                    chipDecoration: ChipDecoration(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    validator: (value) {
                      if (selectedSeats.isEmpty) {
                        return 'اختار المقاعد المناسبة لك';
                      }
                      return null;
                    },
                    onSelectionChange: (newValue) {
                      if (canReserveParking == false) {
                        bookParking = false;
                      }
                      if (newValue.length > 5) {
                        SnackbarHelper.showError(context,
                            title: 'يمكنك اختيار 5 مقاعد كحد أقصى');
                        multiSelectController!.unselectWhere(
                            (value) => value.value == newValue.last);
                        multiSelectController?.closeDropdown();
                      }
                      else {
                        setState(() {
                          canReserveParking = newValue.length >= 3;
                          if (canReserveParking == false) {
                            bookParking = false;
                          }
                          selectedSeats = newValue;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButtonFormField<bool>(
                    value: bookParking,
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "هل تريد حجز موقف لسيارتك؟",
                      labelText: "هل تريد حجز موقف لسيارتك؟",
                      enabled: canReserveParking,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "الرجاء اختيار الخيار";
                      }
                      return null;
                    },
                    items: const [
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text("نعم"),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text("لا"),
                      ),
                    ],
                    onChanged: canReserveParking
                        ? (bool? value) {
                            if (value != null) {
                              bookParking = value;
                            }
                          }
                        : null,
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: PrimaryButton(
            title: "تأكيد الحجز",
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              if (canReserveParking == false) {
                bookParking = false;
              }
              if (multiSelectController!.selectedItems.length > 5) {
                SnackbarHelper.showError(context,
                    title: 'يمكنك اختيار 5 مقاعد كحد أقصى');
                return;
              }
              String? userId = AuthService(
                authProvider:
                    FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
              ).getCurrentUserId();

              if (userId == null) {
                SnackbarHelper.showError(context,
                    title: "يجب عليك تسجيل الدخول من اجل تاكيد الحجز!");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SignInScreen(),
                  ),
                  (route) => false,
                );
                return;
              }

              ParkingReservation? parkingReservation;
              String bookingId = IdGeneratingService.generate();
              String bookingQr = IdGeneratingService.generate();

              if (bookParking) {
                ParkingZone? parkingZone;

                try {
                  parkingZone = widget.match.parking.firstWhere(
                    (parking) =>
                        selectedSection!.parkingZoneIds.contains(parking.id) &&
                        parking.bookedSpots < parking.totalSpots,
                  );
                } catch (e) {
                  parkingZone = null;
                }

                if (parkingZone != null) {
                  setState(() {
                    parkingZone!.bookedSpots += 1;
                  });
                  String parkingId = IdGeneratingService.generate();
                  String parkingQr = IdGeneratingService.generate();
                  parkingReservation = ParkingReservation(
                    id: parkingId,
                    parkingZone: parkingZone,
                    qrCode: parkingQr,
                    validDate: widget.match.dateTime,
                  );
                } else {
                  SnackbarHelper.showError(
                    context,
                    title: "عذرا، لا يوجد مواقف متوفره للحجز",
                  );
                  return;
                }
              }

              Booking booking = Booking(
                id: bookingId,
                userId: userId,
                matchId: widget.match.id,
                bookedSeats: selectedSeats,
                parkingReservation: parkingReservation,
                bookingTime: DateTime.now(),
                totalPrice: selectedSection!.price * selectedSeats.length,
                paymentStatus: "Pending",
                qrCode: bookingQr,
                ticketCategory: selectedSection!.name,
              );

              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => BookingSummaryPage(
                    booking: booking,
                    match: widget.match,
                  ),
                ),
              );
            },
          ),
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
