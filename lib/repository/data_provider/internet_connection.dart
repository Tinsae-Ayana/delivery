import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionAvailabilty {
  InternetConnectionAvailabilty(
      {InternetConnectionChecker? internetConnectionChecker})
      : _internetConnectionChecker =
            internetConnectionChecker ?? InternetConnectionChecker();
  final InternetConnectionChecker _internetConnectionChecker;

  Stream<bool> isConnectedToStatus() {
    return _internetConnectionChecker.onStatusChange.map((connectionStatus) =>
        connectionStatus == InternetConnectionStatus.connected ? true : false);
  }
}
