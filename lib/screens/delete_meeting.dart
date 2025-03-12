import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumitrecordingsapp/providers/meeting_provider.dart';

class DeleteMeeting extends ConsumerStatefulWidget {
  final String meetingId;
  const DeleteMeeting({super.key, required this.meetingId});

  @override
  ConsumerState<DeleteMeeting> createState() => _DeleteMeetingState();
}

class _DeleteMeetingState extends ConsumerState<DeleteMeeting> {
  @override
  Widget build(BuildContext context) {
    final meeting = ref.read(meetingProvider.notifier);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Delete Event?'),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text('Delete'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      meeting.updateMeetingFlied(widget.meetingId,isDeleted: true);
                    },
                  ),
                ],
                content: Text(
                  'are you sure you want to delete this event? this action cannot be undone',
                ),
              );
            },
          );
        },
        icon: Icon(Icons.delete),
      ),
    );
  }
}
