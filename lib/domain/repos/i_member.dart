import 'package:kult/domain/contract/crud.dart';
import 'package:kult/domain/entities/member.dart';

import '../contract/repo.dart';

abstract class IRepoMember extends Repo {
  Future<Member> read(String uid);
  Future<String> create(Member data);
}
