import 'package:flutter/material.dart';
import 'package:sumitrecordingsapp/globals.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String content;
  final IconData icon;
  final Widget? action;
  const InfoRow({
    super.key,
    required this.label,
    required this.content,
    required this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: GlobalColors.background,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          action != null
              ? showDialog(
                context: context,
                builder:
                    (builder) => AlertDialog(
                      title: Text(label),
                      iconPadding: EdgeInsets.all(0),
                      buttonPadding: EdgeInsets.all(0),
                      titlePadding: EdgeInsets.only(top: 20, left: 20),

                      insetPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      content: action,
                    ),
              )
              : '';
        },
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                  color: GlobalColors.gray.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(icon, color: GlobalColors.gray),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(label, style: GlobalTextStyles.title),
                    Text(
                      content,
                      style: GlobalTextStyles.graySubtitle,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
