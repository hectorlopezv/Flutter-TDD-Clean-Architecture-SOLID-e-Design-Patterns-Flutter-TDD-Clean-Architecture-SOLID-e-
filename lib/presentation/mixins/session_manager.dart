import 'package:get/get.dart';

mixin SessionManager on GetxController {
  final _sessionExpired = false.obs;
  Stream<bool> get isSessionExpiredStream => _sessionExpired.stream;
  set sessionExpired(bool value) => _sessionExpired.value = value;
}
