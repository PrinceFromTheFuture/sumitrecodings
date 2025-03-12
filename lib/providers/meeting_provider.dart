import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumitrecordingsapp/main.dart';
import 'package:sumitrecordingsapp/providers/get_random_meetings.dart';
import 'package:sumitrecordingsapp/test/MeetingHive.dart';
import 'package:uuid/uuid.dart';

class Meeting {
  final String name;
  final String meetingId;
  final DateTime date;
  final String location;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isFirstMeetingAtClient;
  final double distance;
  double expectedPayment;
  final bool isReported;
  final String notes;
  bool isDeleteed;

  Meeting({
    required this.name,
    required this.date,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.isFirstMeetingAtClient,
    required this.distance,
    required this.expectedPayment,
    required this.isReported,
    required this.notes,
    required this.meetingId,
    this.isDeleteed = false,
  });

  static double calculateExpectedPayment(Meeting meeting) {
    const hourlyRate = 50;

    const minimumHourCount = 3;
    final test = DateTime.now();
    final meetingLength = test
        .copyWith(hour: meeting.endTime.hour, minute: meeting.endTime.minute)
        .difference(
          test.copyWith(
            hour: meeting.startTime.hour,
            minute: meeting.startTime.minute,
          ),
        );
    print(meetingLength.inMinutes);
    final totalMeetingLength =
        meetingLength.inMinutes / 60 <= minimumHourCount
            ? minimumHourCount
            : meetingLength.inMinutes / 60;
    final extraHours =
        0.5 +
        (meeting.isFirstMeetingAtClient == true
            ? 1
            : 0.5); // the company is required by default to give the workers half an hour at the end and start of a meeting, if the worker is first time at a particulal clinet the comapny demands another half an hour arrval timetotoaling at premeeting addtionl time of 1 h
    return (totalMeetingLength + extraHours) * hourlyRate + meeting.distance;
  }

  static String getMeetingDuration(Meeting meeting) {
    String formattedTime =
        '${meeting.startTime.hour.toString().padLeft(2, '0')}:${meeting.startTime.minute.toString().padLeft(2, '0')} - ${meeting.endTime.hour.toString().padLeft(2, '0')}:${meeting.endTime.minute.toString().padLeft(2, '0')} ';

    return formattedTime;
  }

  Meeting copyWith({
    required Meeting meeting,
    String? name,
    DateTime? date,
    String? location,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isFirstMeetingAtClient,
    double? distance,
    double? expectedPayment,
    bool? isReported,
    bool? isMeetingDeleted,
    String? notes,
  }) {
    final newMeeting = Meeting(
      name: name ?? meeting.name,
      date: date ?? meeting.date,
      location: location ?? meeting.location,
      startTime: startTime ?? meeting.startTime,
      endTime: endTime ?? meeting.endTime,
      isFirstMeetingAtClient:
          isFirstMeetingAtClient ?? meeting.isFirstMeetingAtClient,
      distance: distance ?? meeting.distance,
      expectedPayment: expectedPayment ?? meeting.expectedPayment,
      isReported: isReported ?? meeting.isReported,
      notes: notes ?? meeting.notes,
      meetingId: meeting.meetingId,
      isDeleteed: isMeetingDeleted ?? meeting.isDeleteed,
    );
    newMeeting.expectedPayment = Meeting.calculateExpectedPayment(newMeeting);
    return newMeeting;
  }
}

class MeetingStateNotifier extends StateNotifier<List<Meeting>> {
  MeetingStateNotifier() : super(getRandomMeetings()) {}

  Future<String> addNewMeeting() async {
    final meetingId = Uuid().v4();
    final meeting = Meeting(
      name: 'Edit Meeting Name',
      date: DateTime.now(),
      location: 'Edit Meeting Lcoation',
      startTime: TimeOfDay(hour: 12, minute: 00),
      endTime: TimeOfDay(hour: 15, minute: 00),
      isFirstMeetingAtClient: false,
      distance: 20,
      expectedPayment: 0,
      isReported: false,
      notes: 'notes',
      meetingId: meetingId,
    );
    meeting.expectedPayment = Meeting.calculateExpectedPayment(meeting);
    await boxMeetings.put(
      meetingId,
      MeetingHive(
        title: meeting.name,
        date: meeting.date,
        name: meeting.name,
        meetingId: meetingId,
        location: meeting.location,
        startTimeHour: meeting.startTime.hour,
        endTimeHour: meeting.endTime.minute,
        endTimeMinute: meeting.endTime.hour,
        startTimeMinute: meeting.startTime.minute,
        isFirstMeetingAtClient: meeting.isFirstMeetingAtClient,
        distance: meeting.distance,
        expectedPayment: meeting.expectedPayment,
        isReported: meeting.isReported,
        notes: meeting.notes,
        isDeleteed: meeting.isDeleteed,
      ),
    );
    state = [...state, meeting];
    return meetingId;
  }

  void updateMeetingFlied(
    String meetingId, {
    String? name,
    DateTime? date,
    String? location,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isFirstMeetingAtClient,
    double? distance,
    double? expectedPayment,
    bool? isReported,
    bool? isDeleted,
    String? notes,
  }) {
    state =
        state.map((meeting) {
          if (meeting.meetingId == meetingId) {
            final newMeeting = meeting.copyWith(
              meeting: meeting,
              date: date,
              location: location,
              startTime: startTime,
              distance: distance,
              isFirstMeetingAtClient: isFirstMeetingAtClient,
              notes: notes,
              isReported: isReported,
              expectedPayment: expectedPayment,
              name: name,
              isMeetingDeleted: isDeleted,
              endTime: endTime,
            );
            final MeetingHive databaseNewMeeting = MeetingHive(
              title: newMeeting.name,
              date: newMeeting.date,
              name: newMeeting.name,
              meetingId: newMeeting.meetingId,
              location: newMeeting.location,
              startTimeHour: newMeeting.startTime.hour,
              endTimeHour: newMeeting.endTime.hour,
              endTimeMinute: newMeeting.endTime.minute,
              startTimeMinute: newMeeting.startTime.minute,
              isFirstMeetingAtClient: newMeeting.isFirstMeetingAtClient,
              distance: newMeeting.distance,
              expectedPayment: newMeeting.expectedPayment,
              isReported: newMeeting.isReported,
              notes: newMeeting.notes,
              isDeleteed: newMeeting.isDeleteed,
            );
            boxMeetings.put(meetingId, databaseNewMeeting);
            return newMeeting;
          }
          return meeting;
        }).toList();
  }
}

final meetingProvider =
    StateNotifierProvider<MeetingStateNotifier, List<Meeting>>(
      (ref) => MeetingStateNotifier(),
    );
