import 'package:pmsbweb/models/usuario_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firestore_wrapper/firestore_wrapper.dart' as fw;

class AdministracaoHomePageBloc {
  final fw.Firestore _firestore;

  final usuarioModelListController = BehaviorSubject<List<UsuarioModel>>();

  Stream<List<UsuarioModel>> get usuarioModelListStream =>
      usuarioModelListController.stream;

  AdministracaoHomePageBloc(this._firestore) {
    _firestore
        .collection(UsuarioModel.collection)
        .where("ativo", isEqualTo: true)
        .snapshots()
        .map((listaPerfil) => listaPerfil.documents
            .map((snap) => UsuarioModel(id: snap.documentID).fromMap(snap.data))
            .toList())
        .pipe(usuarioModelListController);
  }

  void dispose() {
    usuarioModelListController.close();
  }
}
