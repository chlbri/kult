import 'model.dart';

abstract class CRUD<T extends Model> {
  create(T arg);
  read(T arg);
  update(T arg);
  delete(T arg);
}
