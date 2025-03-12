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
    return SingleChildScrollView(
      child: Column(
        children: [
          ...meetings
              .where((meeting) => !meeting.isDeleteed)
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
      ),
    );
  }
}
