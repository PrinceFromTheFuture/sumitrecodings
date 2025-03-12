import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumitrecordingsapp/format_currency.dart';
import 'package:sumitrecordingsapp/globals.dart';
import 'package:sumitrecordingsapp/providers/meeting_provider.dart';

String getMonthName(int month) {
  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return monthNames[month - 1];
}

class MonthPayment {
  int month;
  int year;
  double payment;

  MonthPayment({
    required this.month,
    required this.payment,
    required this.year,
  });

  @override
  String toString() {
    return 'MonthPayment(month: $month, year: $year, payment: $payment)';
  }
}

List<MonthPayment> getPaymnetsByMonth(List<Meeting> meetings) {
  List<MonthPayment> paymentsByMonths = [];
  for (final meeting in meetings) {
    final meetingYear = meeting.date.year;
    final meetingMonth = meeting.date.month;

    if (paymentsByMonths.any(
      (paymentByMonth) =>
          paymentByMonth.month == meetingMonth &&
          paymentByMonth.year == meetingYear,
    )) {
      paymentsByMonths
          .firstWhere(
            (paymentByMonth) =>
                paymentByMonth.month == meetingMonth &&
                paymentByMonth.year == meetingYear,
          )
          .payment += meeting.expectedPayment;
    } else {
      paymentsByMonths.add(
        MonthPayment(
          month: meetingMonth,
          payment: meeting.expectedPayment,
          year: meetingYear,
        ),
      );
    }
  }
  return paymentsByMonths;
}

class MonthsPage extends ConsumerWidget {
  const MonthsPage({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final allMeetings = ref.watch(meetingProvider);
    final meetings =
        allMeetings.where((meeting) => !meeting.isDeleteed).toList();
    final paymentsByMonths = getPaymnetsByMonth(meetings);
    return Column(
      children:
          paymentsByMonths.map((monthPayment) {
            return Material(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              color: GlobalColors.background,
              child: InkWell(
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    child: Image.asset('assets/sumit_logo.png'),
                  ),
                  trailing: Icon(Icons.open_in_new),
                  title: Text(formatCurrency(monthPayment.payment)),
                  subtitle: Text(
                    '${getMonthName(monthPayment.month)}, ${monthPayment.year}',
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
