import 'dart:async';

import 'package:sabian_tools/utils/Logger.dart';

void sabianPrint(Object message) {
  Loggers().current.log(message.toString());
}

Timer sabianStartCountDown(int maxSeconds, Function() onFinished) {
  const oneSec = Duration(seconds: 1);
  return Timer.periodic(
    oneSec,
        (Timer timer) {
      if (timer.tick >= maxSeconds) {
        onFinished.call();
        timer.cancel();
      }
    },
  );
}
