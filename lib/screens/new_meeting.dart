import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumitrecordingsapp/providers/meeting_provider.dart';
import 'package:sumitrecordingsapp/screens/single_meeting.dart';
import 'package:uuid/uuid.dart';

class NewMeeting extends ConsumerStatefulWidget {
  const NewMeeting({super.key});

  @override
  ConsumerState<NewMeeting> createState() => _NewMeetingState();
}

class _NewMeetingState extends ConsumerState<NewMeeting> {
  @override
  Widget build(BuildContext context) {
    final meetings = ref.read(meetingProvider.notifier);

    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        final meetingId = await meetings.addNewMeeting();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleMeeting(meetingId: meetingId),
          ),
        );
      },
    );
  }
}
