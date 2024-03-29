import 'package:firestore_wrapper/firestore_wrapper.dart' as fsw;
import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pmsbweb/models/questionario_model.dart';

class QuestionarioFormPageBlocEvent {}

class DeleteQuestionarioFormPageBlocEvent
    extends QuestionarioFormPageBlocEvent {}

class UpdateNomeQuestionarioFormPageBlocEvent
    extends QuestionarioFormPageBlocEvent {
  final String nome;

  UpdateNomeQuestionarioFormPageBlocEvent(this.nome);
}

class UpdateIdQuestionarioFormPageBlocEvent
    extends QuestionarioFormPageBlocEvent {
  final String id;

  UpdateIdQuestionarioFormPageBlocEvent(this.id);
}

class UpdateUserInfoQuestionarioFormPageBlocEvent
    extends QuestionarioFormPageBlocEvent {
  final String userId;
  final String userName;
  final String eixoAtualID;
  final String eixoAtualNome;

  UpdateUserInfoQuestionarioFormPageBlocEvent(
    this.userId,
    this.userName,
    this.eixoAtualID,
    this.eixoAtualNome,
  );
}

class SaveQuestionarioFormPageBlocEvent extends QuestionarioFormPageBlocEvent {}

class QuestionarioFormPageBlocState {
  String id;
  String nome;
  String userId;
  String userName;
  String eixoAtualID;
  String eixoAtualNome;
  String ordem;

  @override
  String toString() {
    return "{$id, $nome, $userId, $userName, $eixoAtualID, $eixoAtualID}";
  }
}

class QuestionarioFormPageBloc {
  final _state = QuestionarioFormPageBlocState();
  final fsw.Firestore _firestore;
  final _authBloc;

  final _inputController = BehaviorSubject<QuestionarioFormPageBlocEvent>();
  final _outputController = BehaviorSubject<QuestionarioFormPageBlocState>();
  final _instanceOutputController = BehaviorSubject<QuestionarioModel>();

  Stream<QuestionarioModel> get instance => _instanceOutputController.stream;

  Function get dispatch => _inputController.add;

  QuestionarioFormPageBloc(this._firestore, this._authBloc) {
    _authBloc.perfil.listen((usuario) {
      dispatch(UpdateUserInfoQuestionarioFormPageBlocEvent(
        usuario.id,
        usuario.nome,
        usuario.eixoIDAtual.id,
        usuario.eixoIDAtual.nome,
      ));
    });
    _inputController.listen(_handleInput);
  }

  void dispose() async {
    await _inputController.drain();
    _inputController.close();
    await _outputController.drain();
    _outputController.close();
    await _instanceOutputController.drain();
    _instanceOutputController.close();
  }

  void _handleInput(QuestionarioFormPageBlocEvent event) async {
    if (event is UpdateNomeQuestionarioFormPageBlocEvent) {
      _state.nome = event.nome;
    }
    if (event is UpdateUserInfoQuestionarioFormPageBlocEvent) {
      _state.userId = event.userId;
      _state.userName = event.userName;
      _state.eixoAtualID = event.eixoAtualID;
      _state.eixoAtualNome = event.eixoAtualNome;
    }
    if (event is UpdateIdQuestionarioFormPageBlocEvent) {
      _state.id = event.id;
      if (_state.id != null) {
        final colRef = _firestore.collection(QuestionarioModel.collection);
        final docRef = colRef.document(_state.id);
        docRef.get().then((docSnap) {
          final modelInstance =
              QuestionarioModel(id: docSnap.documentID).fromMap(docSnap.data);

          _instanceOutputController.add(modelInstance);
        });
      }
    }

    if (event is SaveQuestionarioFormPageBlocEvent) {
      final colRef = _firestore.collection(QuestionarioModel.collection);
      final docRef = colRef.document(_state.id);

      final modelInstance = QuestionarioModel(
        id: _state.id,
        nome: _state.nome,
        criou: _state.id == null
            ? UsuarioQuestionario(id: _state.userId, nome: _state.userName)
            : null,
        editou: UsuarioQuestionario(id: _state.userId, nome: _state.userName),
        eixo: Eixo(id: _state.eixoAtualID, nome: _state.eixoAtualNome),
        criado: _state.id == null
            ? Bootstrap.instance.FieldValue.serverTimestamp()
            : null,
        modificado: Bootstrap.instance.FieldValue.serverTimestamp(),
        editando: false,
      );

      if (_state.id == null) {
        final eixoRef = _firestore
            .collection(EixoModel.collection)
            .document(_state.eixoAtualID);
        var docSnap = await eixoRef.get();
        int ultimaOrdemQuestionario = docSnap.data['ultimaOrdemQuestionario'];
        modelInstance.ordem = ultimaOrdemQuestionario + 1;
        eixoRef.setData({"ultimaOrdemQuestionario": modelInstance.ordem},
            merge: true);
      }

      docRef.setData(modelInstance.toMap(), merge: true);
    }

    if (event is DeleteQuestionarioFormPageBlocEvent) {
      _firestore
          .collection(QuestionarioModel.collection)
          .document(_state.id)
          .delete();
    }
    _outputController.add(_state);
  }
}
