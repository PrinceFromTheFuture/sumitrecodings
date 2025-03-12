import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumitrecordingsapp/globals.dart';
import 'package:sumitrecordingsapp/providers/meeting_provider.dart';

class EditLocation extends ConsumerStatefulWidget {
  final String intialLocation;
  final String meetingId;

  const EditLocation({
    super.key,
    required this.intialLocation,
    required this.meetingId,
  });

  @override
  ConsumerState<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends ConsumerState<EditLocation> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.intialLocation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meeting = ref.read(meetingProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              controller.text = value;
            });
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('save'),
              onPressed: () {
                meeting.updateMeetingFlied(
                  widget.meetingId,
                  location: controller.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class EditNotes extends ConsumerStatefulWidget {
  final String initialNotes;
  final String meetingId;

  const EditNotes({
    super.key,
    required this.initialNotes,
    required this.meetingId,
  });

  @override
  ConsumerState<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends ConsumerState<EditNotes> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialNotes);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meeting = ref.read(meetingProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              controller.text = value;
            });
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('save'),
              onPressed: () {
                meeting.updateMeetingFlied(
                  widget.meetingId,
                  notes: controller.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class EditDistance extends ConsumerStatefulWidget {
  final double initialDistance;
  final String meetingId;

  const EditDistance({
    super.key,
    required this.initialDistance,
    required this.meetingId,
  });

  @override
  ConsumerState<EditDistance> createState() => _EditDistanceState();
}

class _EditDistanceState extends ConsumerState<EditDistance> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialDistance.toString());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meeting = ref.read(meetingProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number, // Only nume
          onChanged: (value) {
            setState(() {
              controller.text = value;
            });
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('save'),
              onPressed: () {
                Navigator.pop(context);

                try {
                  double distance = double.parse(controller.text);
                  meeting.updateMeetingFlied(
                    widget.meetingId,
                    distance: distance,
                  );
                } catch (e) {
                  print('object');
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class EditDate extends ConsumerStatefulWidget {
  final DateTime initialDate;
  final String meetingId;

  const EditDate({
    super.key,
    required this.initialDate,
    required this.meetingId,
  });

  @override
  ConsumerState<EditDate> createState() => _EditDateState();
}

class _EditDateState extends ConsumerState<EditDate> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final meeting = ref.read(meetingProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            final pickedDate = await showDatePicker(
              helpText: '',

              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(3000),
            );
            if (pickedDate != null && pickedDate != selectedDate) {
              selectedDate = pickedDate;
              meeting.updateMeetingFlied(widget.meetingId, date: pickedDate);
            }
          },
          child: Text(
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('save'),
            ),
          ],
        ),
      ],
    );
  }
}

class EditeTime extends ConsumerStatefulWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String meetingId;

  const EditeTime({
    super.key,
    required this.endTime,
    required this.startTime,
    required this.meetingId,
  });

  @override
  ConsumerState<EditeTime> createState() => _EditeTimeState();
}

class _EditeTimeState extends ConsumerState<EditeTime> {
  TimeOfDay? newStartTime;
  TimeOfDay? newEndTime;
  @override
  void initState() {
    super.initState();
    newStartTime = widget.startTime;
    newEndTime = widget.endTime;
  }

  @override
  Widget build(BuildContext context) {
    final meeting = ref.read(meetingProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Start', style: GlobalTextStyles.subtitle),
        ElevatedButton(
          onPressed: () async {
            final TimeOfDay? startTime = await showTimePicker(
              context: context,
              initialTime: widget.startTime,
            );
            if (startTime != null) {
              setState(() {
                newStartTime = startTime;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Adjust the radius here
            ),
          ),
          child: Text(
            '  ${newStartTime!.hour.toString().padLeft(2, '0')}:${newStartTime!.minute.toString().padLeft(2, '0')}',
          ),
        ),
        Text('End', style: GlobalTextStyles.subtitle),

        ElevatedButton(
          onPressed: () async {
            final TimeOfDay? endTime = await showTimePicker(
              context: context,
              initialTime: widget.startTime,
            );

            if (endTime != null) {
              setState(() {
                newEndTime = endTime;
                print(endTime);
              });
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Adjust the radius here
            ),
          ),
          child: Text(
            '${newEndTime!.hour.toString().padLeft(2, '0')}:${newEndTime!.minute.toString().padLeft(2, '0')}',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (newStartTime!.isAfter(newEndTime!)) return;
                meeting.updateMeetingFlied(
                  widget.meetingId,
                  startTime: newStartTime,
                  endTime: newEndTime,
                );
              },
              child: Text('save'),
            ),
          ],
        ),
      ],
    );
  }
}

class EditTitle extends ConsumerStatefulWidget {
  final String initialTitle;
  final String meetingId;

  const EditTitle({
    super.key,
    required this.initialTitle,
    required this.meetingId,
  });

  @override
  ConsumerState<EditTitle> createState() => _EditTitleState();
}

class _EditTitleState extends ConsumerState<EditTitle> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meeting = ref.read(meetingProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              controller.text = value;
            });
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('save'),
              onPressed: () {
                meeting.updateMeetingFlied(
                  widget.meetingId,
                  name: controller.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
