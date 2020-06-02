import 'package:kult/data/datasources/firebase/choice.dart';
import 'package:kult/data/models/choice.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/choice.dart';
import 'package:kult/domain/repos/i_choice.dart';

class RepoChoice extends IRepoChoice {
  final FireStoreChoiceSource source;

  RepoChoice({
    this.source,
  });

  update(data, {uid}) {
    final model = ChoiceModel.fromEntity(data);
    return source.update(model..uid = uid);
  }

  @override
  read(uid) {
    return source.read(uid);
  }

  @override
  delete(uid) {
    return source.delete(uid);
  }
}
