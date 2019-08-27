import 'package:firestore_wrapper/firestore_wrapper.dart' as fsw;
import 'package:firestore_wrapper_web/firestore_wrapper_web.dart' as ffsw;
import 'package:pmsbweb/api/auth_api_mobile.dart';
import 'package:pmsbweb/state/auth_bloc.dart';

class Bootstrap {
  static final Bootstrap instance =
      Bootstrap(ffsw.Firestore(), ffsw.FieldValue());
  final fsw.Firestore firestore;
  final fsw.FieldValue FieldValue;
  final AuthBloc authBloc;
  Bootstrap(this.firestore, this.FieldValue)
      : authBloc = AuthBloc(AuthApiMobile(), firestore);
}
