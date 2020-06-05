import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/choice.dart';
import 'package:kult/data/repos/choice.dart';
import 'package:kult/domain/entities/choice.dart';
import 'package:kult/domain/repos/i_choice.dart';

class ChooseKult {
  final IRepoChoice repoChoice;
  ChooseKult({
    this.repoChoice,
  });

  Future update(Choice data, {String uid}) {
    final out = isNullStringEvery([data.uid, uid])
        ? null
        : repoChoice.update(data, uid: uid);
    return out;
  }

  Future<bool> remove(String uid) {
    return isNullString(uid) ? null : repoChoice.delete(uid);
  }

  Future<Choice> read(String uid) {
    return isNullString(uid) ? null : repoChoice.read(uid);
  }
}

final chooseKultContainer = ChooseKult(
  repoChoice: RepoChoice(
    source: FireStoreChoiceSource(),
  ),
);
