import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date;

import '../../../../Data/Model/Match/match.model.dart';
import '../../../../Data/Model/booking/booking.model.dart';
import '../../../../Data/Model/seat/seat.model.dart';
import '../../../../Data/Repositories/booking_repo.dart';
import '../../../../Data/Repositories/match.repo.dart';
import '../../../../core/widgets/info_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../skeleton/skeleton.dart';

class BookingSummaryPage extends StatelessWidget {
  final Booking booking;
  final Match match;

  const BookingSummaryPage({
    Key? key,
    required this.booking,
    required this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> updateMatchSeats(Match match, List<Seat> bookedSeats) async {
      try {
        for (var classification in match.seatClassifications) {
          for (var seat in classification.seats) {
            if (bookedSeats.any((bookedSeat) => bookedSeat.id == seat.id)) {
              seat.isAvailable = false;
            }
          }
        }
        await MatchesRepo().updateSingle(match.id, match);
      } catch (e) {
        print('Failed to update match: $e');
      }
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ملخص الحجز'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'تفاصيل المباراة',
              ),
              // const SizedBox(height: 8),
              // Center(
              //   child: QrImageView(
              //     data: booking.qrCode,
              //     version: QrVersions.auto,
              //     gapless: false,
              //   ),
              // ),
              BuildInfoRow(
                label: "المباراه",
                value:
                "${match.firstTeam} X ${match.secondTeam}",
              ),
              BuildInfoRow(
                label: "الوصف",
                value: match.matchDescription,
              ),
              BuildInfoRow(
                label: "تاريخ المباراه",
                value: date.DateFormat('yy-MM-dd')
                    .format(match.dateTime),
              ),
              BuildInfoRow(
                label: "موعد بدء المباراه",
                value:
                date.DateFormat('hh:mm').format(match.dateTime),
              ),
              const Divider(height: 20),
              const SectionTitle(
                title: 'المقاعد المحجوزة',
              ),
              BuildInfoRow(
                label: "اسم الفئة:",
                value: booking.ticketCategory,
              ),
              ...booking.bookedSeats.map((seat) =>
                  BuildInfoRow(label: "المقعد رقم:", value: '${seat.number}')),
              BuildInfoRow(
                label: "إجمالي السعر:",
                value: '${booking.totalPrice}ر.س',
              ),
              const Divider(height: 20),
              if (booking.parkingReservation != null) ...[
                Text(
                  'تفاصيل حجز موقف السيارة',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,
                ),
                BuildInfoRow(
                  label: "صالح يوم:",
                  value: date.DateFormat('dd-MM-yyyy')
                      .format(booking.parkingReservation!.validDate),
                ),
              ],
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: PrimaryButton(
            title: "تأكيد الحجز",
            onPressed: () async {
              await BookingRepo().createSingle(
                itemId: booking.id,
                booking,
              );
              await updateMatchSeats(match, booking.bookedSeats);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Skeleton(),
                ),
                    (route) => false,
              );
            },
          ),
        ),
      ),
    );
  }
}
