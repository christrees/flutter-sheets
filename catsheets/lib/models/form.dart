class FeedbackForm {
  String _when;
  String _who;
  String _what;
  String _which;
  String _why;
  String _where;
  String _photo;
  FeedbackForm(this._when, this._who, this._what, this._which, this._why,
      this._where, this._photo);
  String toParams() =>
      "?when=$_when&who=$_who&what=$_what&which=$_which&why=$_why&where=$_where&photo=$_photo";
}
