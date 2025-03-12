import 'package:sumitrecordingsapp/globals.dart';
import 'package:sumitrecordingsapp/providers/meeting_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumitrecordingsapp/views/meetings/single_meeting_preview/single_meeting_preview.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final meetings = ref.watch(meetingProvider);
    final sortedMeetings =
        [...meetings].where((meeting) => !meeting.isDeleteed).toList();
    sortedMeetings.sort((a, b) => b.date.compareTo(a.date));
    return SingleChildScrollView(
      child:
          sortedMeetings.length > 0
              ? Column(
                children: [
                  ...sortedMeetings
                      .expand(
                        (meeting) => [
                          SingleMeetingPreview(meeting: meeting),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              color: Color.fromARGB(255, 216, 216, 216),
                              height: 1,
                            ),
                          ), // Add a divider after each item
                        ],
                      )
                      .toList(),
                ],
                // Remove the last divider
              )
              : Container(
                height: 400,
                child: Center(
                  child: Text('No meetings yet, press + to add your first'),
                ),
              ),
    );
  }
}
