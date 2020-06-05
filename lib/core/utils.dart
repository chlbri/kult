abstract class Checker {
  bool call();
}

class TypeChecker2<T> extends Checker {
  final Type type;
  final dynamic value;

  TypeChecker2(
    this.type,
    this.value,
  );

  call() => isNull(value) || value.runtimeType == type;
}

class TypeChecker<T> extends Checker {
  final dynamic value;

  TypeChecker(
    this.value,
  );

  call() => isNull(value) || value is T;
}

class TypeManyChecker<T> extends Checker {
  final List value;

  TypeManyChecker(
    this.value,
  );

  call() =>
      isNull(value) ||
      value.isEmpty ||
      value.every(
        (element) => TypeChecker<T>(element)(),
      );
}

class TypedVariable {
  final Type type;
  final String value;
  final FunctionChecker func;

  TypedVariable(
    this.type,
    this.value, [
    this.func,
  ]);
}

class FunctionChecker<T> extends Checker {
  final bool Function(T) func;
  final dynamic value;

  FunctionChecker(
    this.func,
    this.value,
  );

  call() {
    return isNull(value) || (value is T && func(value));
  }
}

extension MapExtension<K, V> on Map<K, V> {
  void put(K key, V value) {
    if (isNullAny([value, key])) return;
    this[key] = value;
  }
}

bool checkTypes(List<Checker> toCheck) {
  return toCheck.every(
    (element) => element(),
  );
}

bool isNull(arg) => arg == null;
bool isNullString(String arg) => arg == null || arg.isEmpty;

bool isTrue(bool arg) => arg == null ? false : arg ;

bool isNullList(List args) => args.every(isNull);
bool isNullAny(List args) => args.any(isNull);

bool checkFunction(bool Function() arg) => arg == null || arg();

String forceStringRender([String arg]) => arg ??= '';

bool isNullStringAny(List<String> args) => args.any(isNullString);
bool isNullStringEvery(List<String> args) => args.every(isNullString);
