
abstract class CRUD<T> {
  Future create(T arg);
  Future read(T arg);
  Future update(T arg);
  Future delete(String uid);
}
