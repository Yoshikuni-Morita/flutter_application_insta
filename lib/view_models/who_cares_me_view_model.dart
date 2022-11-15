import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/models/repositories/user_repository.dart';
import 'package:insta_clone/utils/constants.dart';

class WhoCaresMeViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  WhoCaresMeViewModel({required this.userRepository});

  List<User> caresMeUsers = [];

  User get currentUser => UserRepository.currentUser!;

  Future<void> getCaresMeUsers(String id, WhoCaresMeMode mode) async {
    caresMeUsers = await userRepository.getCaresMeUsers(id, mode);
    notifyListeners();
  }
}
