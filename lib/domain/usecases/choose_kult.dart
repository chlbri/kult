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
    return repoChoice.update(data, uid: uid);
  }

  Future remove(String uid) {
    return repoChoice.delete(uid);
  }
  Future<Choice> read(String uid) {
    return repoChoice.read(uid);
  }
}

final chooseKultContainer = ChooseKult(
  repoChoice: RepoChoice(
    source: FireStoreChoiceSource(),
  ),
);
