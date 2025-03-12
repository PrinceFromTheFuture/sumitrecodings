import 'package:flutter/material.dart';
import 'package:sumitrecordingsapp/main.dart';
import 'package:sumitrecordingsapp/providers/meeting_provider.dart';
import 'package:sumitrecordingsapp/test/MeetingHive.dart';

final DateTime now = DateTime.now().copyWith(
  second: 0,
  millisecond: 0,
  microsecond: 0,
);

final DateTime nowPlus3 = DateTime.now()
    .add(Duration(hours: 3))
    .copyWith(second: 0, millisecond: 0, microsecond: 0);

List<Meeting> getRandomMeetings() {
  // Cast boxMeetings.values to List<MeetingHive> explicitly

  final List<Meeting> values =
      boxMeetings.values.map((hiveMeeting) {
        return Meeting(
          date: hiveMeeting.date,
          distance: hiveMeeting.distance,
          endTime: TimeOfDay(
            hour: hiveMeeting.endTimeHour,
            minute: hiveMeeting.endTimeMinute,
          ),
          startTime: TimeOfDay(
            hour: hiveMeeting.startTimeHour,
            minute: hiveMeeting.startTimeMinute,
          ),

          expectedPayment: hiveMeeting.expectedPayment,
          location: hiveMeeting.location,
          isFirstMeetingAtClient: hiveMeeting.isFirstMeetingAtClient,
          name: hiveMeeting.name,
          isReported: hiveMeeting.isReported,
          meetingId: hiveMeeting.meetingId,
          notes: hiveMeeting.notes,
          isDeleteed: hiveMeeting.isDeleteed,
        );
      }).toList(); // Convert the Iterable to a List<Meeting>
  return values;
}
