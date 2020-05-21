import 'package:kult/ebr/entities/contract/credentials.dart';
import 'package:kult/ebr/entities/contract/human.dart';
import 'package:kult/ebr/entities/contract/timestamps.dart';

import 'contract/Id.dart';
import 'contract/updates.dart';

class Preacher with Id, Credentials, Human, Timestamps, Updates<Preacher> {}
