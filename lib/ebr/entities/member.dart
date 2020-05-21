import 'package:kult/ebr/entities/contract/credentials.dart';
import 'package:kult/ebr/entities/contract/human.dart';
import 'package:kult/ebr/entities/contract/timestamps.dart';
import 'package:kult/ebr/entities/contract/updates.dart';

import 'contract/Id.dart';

class Member with Id, Credentials, Human, Timestamps, Updates<Member> {}
