import 'package:meta/meta.dart';

class Update<T> {
  final DateTime date;
  final T before, after;

  const Update(this.date, this.before, this.after);

  factory Update.fromJson({
    dynamic map,
    @required bool Function(dynamic) validator,
  }) {
    final check = map is Map<String, dynamic> &&
        [map['before'], map['after']].every(validator) &&
        map['date'] is DateTime;
    return check
        ? Update(
            map['date'],
            map['before'],
            map['after'],
          )
        : null;
  }
}
