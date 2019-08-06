import 'package:firestore_wrapper/firestore_wrapper.dart' as fsw;
import 'package:firestore_wrapper_web/firestore_wrapper_web.dart' as ffsw;

class Bootstrap {
  static final Bootstrap instance = Bootstrap(ffsw.Firestore(),  ffsw.FieldValue());
  final fsw.Firestore firestore;
  final fsw.FieldValue FieldValue;

  Bootstrap(this.firestore, this.FieldValue);
}
