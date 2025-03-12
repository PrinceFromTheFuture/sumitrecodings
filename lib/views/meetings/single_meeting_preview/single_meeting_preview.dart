import 'package:sumitrecordingsapp/main.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:sumitrecordingsapp/format_currency.dart';
import 'package:sumitrecordingsapp/globals.dart';
import 'package:sumitrecordingsapp/providers/meeting_provider.dart';
import 'package:sumitrecordingsapp/screens/single_meeting.dart';

class SingleMeetingPreview extends StatelessWidget {
  final Meeting meeting;
  const SingleMeetingPreview({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: GlobalColors.background,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleMeeting(meetingId: meeting.meetingId),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.0,
            bottom: 15,
            left: 15.0,
            right: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Text(meeting.name, style: GlobalTextStyles.title),
              ),

              NormalDevider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Expected payment',
                        style: GlobalTextStyles.graySubtitle,
                      ),
                      SizedBox(height: 5),

                      Text(
                        formatCurrency(meeting.expectedPayment),
                        style: GlobalTextStyles.title,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('When', style: GlobalTextStyles.graySubtitle),
                      SizedBox(height: 5),

                      Text(
                        timeago.format(
                          meeting.date.copyWith(
                            hour: meeting.endTime.hour,
                            minute: meeting.endTime.minute,
                          ),
                        ),
                        style: GlobalTextStyles.title,
                      ),
                    ],
                  ),
                ],
              ),
              NormalDevider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color:
                            meeting.isReported
                                ? Colors.green[50]
                                : Colors.red[50],
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          meeting.isReported ? 'Reported' : 'Unreported',
                          style: GlobalTextStyles.subtitle.copyWith(
                            color:
                                meeting.isReported ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: GlobalColors.lightGray,
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '${DateTime.now().copyWith(hour: meeting.endTime.hour, millisecond: 0, microsecond: 0, minute: meeting.endTime.minute).difference(DateTime.now().copyWith(microsecond: 0, hour: meeting.startTime.hour, millisecond: 0, minute: meeting.startTime.minute)).inMinutes} Minutes',
                          style: GlobalTextStyles.subtitle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: GlobalColors.lightGray,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
