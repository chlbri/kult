import 'contract/credentials.dart';
import 'contract/human.dart';
import 'contract/timestamps.dart';

import 'contract/Id.dart';

class Member with Id, Credentials, Human, Timestamps {
  String phoneNumber;
}
