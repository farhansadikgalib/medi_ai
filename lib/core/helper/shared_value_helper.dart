import 'package:shared_value/shared_value.dart';

final SharedValue<bool> isLoggedIn = SharedValue(
  value: false,
  key: "isLoggedIn",
);
final SharedValue<String> accessToken = SharedValue(
  value: "",
  key: "accessToken",
);


final SharedValue<String> email = SharedValue(
  value: "",
  key: "email",
);

final SharedValue<String> userName = SharedValue(
  value: "",
  key: "userName",
);

final SharedValue<bool> onBoardView = SharedValue(
  value: true,
  key: "onBoardView",
);




