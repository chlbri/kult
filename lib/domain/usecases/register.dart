import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/data/repos/member.dart';
import 'package:kult/domain/contract/usecase.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/repos/i_member.dart';

class Register extends UseCase {
  final IRepoMember repoMember;

  Register(this.repoMember);

  Future<String> create(Member member) async {
    if (isNullList([
      member.firstNames,
      member.lastName,
    ])) return null;
    return await repoMember.create(member);
  }
  Future<String> update(Member member) async {
    if (isNullList([
      member.firstNames,
      member.lastName,
    ])) return null;
    return await repoMember.update(member);
  }

  Future<Member> read(String uid) {
    return repoMember.read(uid);
  }

  Future<List<Member>> readAll(Member data) {
    return repoMember.readAll(data);
    // return repoMember.read(uid);
  }

  Future<ResultMemberMany> readMore(
    Member data, {
    int limit,
    String uid,
  }) {
    return repoMember.readMore(
      data,
      limit: limit,
      uid: uid,
    );
    // return repoMember.read(uid);
  }
}

final registerContainer = Register(
  RepoMember(
    source: FirestoreMemberSource(),
  ),
);
