import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'AccountHive.g.dart'; // This will be generated by build_runner

@HiveType(typeId: 1)
class AccountHive {
  @HiveField(0)
  bool isFirstLogin;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  AccountHive({
    required this.firstName,
    required this.isFirstLogin,
    required this.lastName,
  });
}
