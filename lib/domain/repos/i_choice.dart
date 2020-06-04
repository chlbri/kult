import 'package:kult/domain/contract/crud.dart';
import 'package:kult/domain/entities/choice.dart';

import '../contract/repo.dart';

abstract class IRepoChoice extends Repo{
  Future update(Choice data,{String uid});
  Future<Choice> read(String uid);
  Future<bool> delete(String uid);
}
