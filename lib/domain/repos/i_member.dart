import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/domain/contract/crud.dart';
import 'package:kult/domain/entities/member.dart';

import '../contract/repo.dart';

abstract class IRepoMember extends Repo {
  Future<Member> read(String uid);
  Future<List<Member>> readAll(Member data);
  Future<String> create(Member data);

  Future<ResultMemberMany> readMore(
    Member data, {
    int limit,
    String uid,
  });

  Future<String> update(Member member);
}
