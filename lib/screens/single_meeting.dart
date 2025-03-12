import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumitrecordingsapp/format_currency.dart';
import 'package:sumitrecordingsapp/globals.dart';
import 'package:sumitrecordingsapp/providers/meeting_provider.dart';
import 'package:sumitrecordingsapp/screens/HeaderIcon.dart';
import 'package:sumitrecordingsapp/screens/Info_row.dart';
import 'package:sumitrecordingsapp/screens/delete_meeting.dart';
import 'package:sumitrecordingsapp/screens/info_actions.dart/info_actions.dart';

class SingleMeeting extends ConsumerWidget {
  final String meetingId;
  const SingleMeeting({super.key, required this.meetingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meeting = ref.watch(meetingProvider).firstWhere((meeting) {
      return meeting.meetingId == meetingId;
    });
    final meetingProviderNotif = ref.read(meetingProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: GlobalColors.white,
        backgroundColor: GlobalColors.orange,
        title: Text(meeting.name),
        actions: [DeleteMeeting(meetingId: meeting.meetingId)],
      ),
      backgroundColor: GlobalColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderIcon(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Sumit Recordings Event',
                    style: GlobalTextStyles.titleXL,
                  ),
                  Center(
                    child: Text(
                      meeting.name,
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.graySubtitle,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoBadge(
                        icon: Icons.currency_exchange,
                        iconColor: GlobalColors.orange,
                        label: ' Payment',
                        content: formatCurrency(meeting.expectedPayment),
                      ),
                      SizedBox(width: 10),
                      InfoBadge(
                        icon: meeting.isReported ? Icons.check : Icons.close,
                        iconColor:
                            meeting.isReported ? Colors.green : Colors.red,
                        label: 'Reported',
                        content: meeting.isReported ? 'Yes' : 'No',
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoRow(
                          content: meeting.name,
                          icon: Icons.title,
                          label: "Title",
                          action: EditTitle(
                            initialTitle: meeting.name,
                            meetingId: meeting.meetingId,
                          ),
                        ),
                        InfoRow(
                          content:
                              '${meeting.date.day}/${meeting.date.month}/${meeting.date.year}',
                          icon: Icons.calendar_today,
                          label: "Date",
                          action: EditDate(
                            initialDate: meeting.date,
                            meetingId: meeting.meetingId,
                          ),
                        ),
                        InfoRow(
                          content: Meeting.getMeetingDuration(meeting),
                          icon: Icons.schedule,
                          label: "Time",
                          action: EditeTime(
                            meetingId: meeting.meetingId,
                            startTime: meeting.startTime,
                            endTime: meeting.endTime,
                          ),
                        ),

                        InfoRow(
                          content: meeting.location,
                          icon: Icons.place,
                          label: "Location",
                          action: EditLocation(
                            intialLocation: meeting.location,
                            meetingId: meeting.meetingId,
                          ),
                        ),

                        InfoRow(
                          content: '${meeting.distance.toString()} km',
                          icon: Icons.straighten,
                          label: "Distance ",
                          action: EditDistance(
                            meetingId: meeting.meetingId,
                            initialDistance: meeting.distance,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: InfoRow(
                                content:
                                    meeting.isFirstMeetingAtClient
                                        ? 'Yes'
                                        : "no",
                                icon: Icons.group,
                                label: "First Meeting At Client? ",
                              ),
                            ),

                            Switch.adaptive(
                              value: meeting.isFirstMeetingAtClient,
                              onChanged: (val) {
                                meetingProviderNotif.updateMeetingFlied(
                                  meetingId,
                                  isFirstMeetingAtClient: val,
                                );
                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: InfoRow(
                                content: meeting.isReported ? 'Yes' : "no",
                                icon: Icons.group,
                                label: "is Reported? ",
                              ),
                            ),

                            Switch.adaptive(
                              value: meeting.isReported,
                              onChanged: (val) {
                                meetingProviderNotif.updateMeetingFlied(
                                  meetingId,
                                  isReported: val,
                                );
                              },
                            ),
                          ],
                        ),

                        InfoRow(
                          content: meeting.notes,
                          icon: Icons.notes,
                          label: "Notes ",
                          action: EditNotes(
                            initialNotes: meeting.notes,
                            meetingId: meetingId,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String content;
  const InfoBadge({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: GlobalColors.lightGray,

          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(icon, color: iconColor),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: GlobalTextStyles.graySubtitle),
                  SizedBox(height: 5),
                  Text(content, style: GlobalTextStyles.title),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
