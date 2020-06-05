import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/repos/i_member.dart';

class RepoMember extends IRepoMember {
  final FirestoreMemberSource source;

  RepoMember({
    this.source,
  });

  create(data) {
    final model = MemberModel.fromEntity(data);
    return source.create(model);
  }

  read(uid) {
    return source.read(uid);
  }

  // Future update(data) {
  //   final model = MemberModel.fromEntity(data);

  //   // TODO: implement create
  //   throw UnimplementedError();
  // }

  // Future delete(String uid) {
  //   // TODO: implement create
  //   throw UnimplementedError();
  // }

  @override
  readAll(data) {
    final _data = MemberModel.fromEntity(data);
    return source.readAll(_data);
  }

  @override
  readMore(
    data, {
    limit,
    uid,
  }) {
    final _data = MemberModel.fromEntity(data);
    return source.readMore(
      _data,
      limit: limit,
      uid: uid,
    );
  }

  @override
  update(data) {
    final _data = MemberModel.fromEntity(data);
    return source.update(_data);
  }
}
