import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/data/repos/member.dart';
import 'package:kult/domain/contract/usecase.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/repos/i_member.dart';

class Register extends UseCase {
  final IRepoMember repoMember;

  Register(this.repoMember);

  call(Member member) {
    if (isNullList([
      member.firstNames,
      member.lastName,
    ])) return null;
    return repoMember.create(member);
  }

  Future<Member> read(String uid){
    return repoMember.read(uid);
  }
}


final registerContainer = Register(
  RepoMember(
    source: FirestoreMemberSource(),
  ),
);