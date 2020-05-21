
class Update<T>{
  final DateTime date;
  final T before, after;

  Update(this.date, this.before, this.after);
}
