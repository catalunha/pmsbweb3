import 'package:firestore_wrapper/firestore_wrapper.dart' as fsw;
import 'package:pmsbweb/models/eixo_model.dart';
import 'package:pmsbweb/models/usuario_model.dart';
import 'package:queries/collections.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pmsbweb/models/questionario_model.dart';
import 'package:pmsbweb/bootstrap.dart' as fsw;
import 'dart:async';

class QuestionarioHomePageEvent {}

class UpdateUserInfoQuestionarioHomePageBlocEvent
    extends QuestionarioHomePageEvent {
  final UsuarioModel user;

  UpdateUserInfoQuestionarioHomePageBlocEvent(this.user);
}

class UpdateQuestionarioListQuestionarioHomePageEvent
    extends QuestionarioHomePageEvent {
  final List<QuestionarioModel> questionarios;

  UpdateQuestionarioListQuestionarioHomePageEvent(this.questionarios);
}

class OrdenarQuestionarioEvent extends QuestionarioHomePageEvent {
  final String questionarioID;
  final bool up;

  OrdenarQuestionarioEvent(this.questionarioID, this.up);
}

class QuestionarioHomePageBlocState {
  String questionarioID;
  String usuarioID;
  String eixoAtualID;
  bool isDataValid;

  Map<String, QuestionarioModel> questionarioMap =
      Map<String, QuestionarioModel>();
}

class QuestionarioHomePageBloc {
  final fsw.Firestore _firestore;
  final _authBloc;

  //Eventos
  final _eventController = BehaviorSubject<QuestionarioHomePageEvent>();

  Stream<QuestionarioHomePageEvent> get eventStream => _eventController.stream;

  Function get eventSink => _eventController.sink.add;

  //Estados
  final QuestionarioHomePageBlocState _state = QuestionarioHomePageBlocState();
  final _stateController = BehaviorSubject<QuestionarioHomePageBlocState>();

  Stream<QuestionarioHomePageBlocState> get stateStream =>
      _stateController.stream;

  Function get stateSink => _stateController.sink.add;

  // final _questionariosController = BehaviorSubject<List<QuestionarioModel>>();
  // Stream<List<QuestionarioModel>> get questionarios =>
  //     _questionariosController.stream;

  StreamSubscription<List<QuestionarioModel>> _questionarioSubscription;

  //QuestionarioModel List
  final _questionarioMapController =
      BehaviorSubject<Map<String, QuestionarioModel>>();

  Stream<Map<String, QuestionarioModel>> get questionarioMapStream =>
      _questionarioMapController.stream;

  Function get questionarioMapSink => _questionarioMapController.sink.add;

  QuestionarioHomePageBloc(this._firestore, this._authBloc) {
    _eventController.listen(_mapEventToState);
    _authBloc.perfil.listen((user) {
      eventSink(UpdateUserInfoQuestionarioHomePageBlocEvent(user));
    });
  }

  void dispose() async {
    await _eventController.drain();
    _eventController?.close();
    await _stateController.drain();
    _stateController?.close();
    _questionarioSubscription?.cancel();
    await _questionarioMapController.drain();
    _questionarioMapController?.close();
  }

  _validateData() {
    if (_state.questionarioMap != null) {
      _state.isDataValid = true;
    } else {
      _state.isDataValid = false;
    }
  }

  void _mapEventToState(QuestionarioHomePageEvent event) async {
    if (event is UpdateUserInfoQuestionarioHomePageBlocEvent) {
      _state.usuarioID = event.user.id;
      _state.eixoAtualID = event.user.eixoIDAtual.id;

      final ref = _firestore
          .collection(QuestionarioModel.collection)
          .where("eixo.id", isEqualTo: _state.eixoAtualID);
      final snap = ref.snapshots();
      final snapList = snap.map((q) => q.documents
          .map((d) => QuestionarioModel(id: d.documentID).fromMap(d.data))
          .toList());
      if (_questionarioSubscription != null) {
        await _questionarioSubscription.cancel();
      }
      _questionarioSubscription = snapList.listen((questionarioModelList) {
        eventSink(UpdateQuestionarioListQuestionarioHomePageEvent(
            questionarioModelList));
      });
    }

    if (event is UpdateQuestionarioListQuestionarioHomePageEvent) {
      _state.questionarioMap.clear();
      for (var questionario in event.questionarios) {
        _state.questionarioMap[questionario.id] = questionario;
      }

      var dicDesordenado = Dictionary.fromMap(_state.questionarioMap);
      var dicOrdenadado = dicDesordenado
          // Sort Ascending order by value ordem
          .orderBy((kv) => kv.value.ordem)
          // Sort Descending order by value ordem
          // .orderByDescending((kv) => kv.value.ordem)
          .toDictionary$1((kv) => kv.key, (kv) => kv.value);
      // print(dicOrdenadado.toMap());
      _state.questionarioMap = dicOrdenadado.toMap();
    }

    if (event is OrdenarQuestionarioEvent) {
      List<QuestionarioModel> valuesList =
          _state.questionarioMap.values.toList();
      List<String> keyList = _state.questionarioMap.keys.toList();
      final ordemOrigem = keyList.indexOf(event.questionarioID);
      final ordemOutro = event.up ? ordemOrigem - 1 : ordemOrigem + 1;
      QuestionarioModel questionarioOrigem = valuesList[ordemOrigem];
      QuestionarioModel questionarioOutro = valuesList[ordemOutro];
      String keyOrigem = keyList[ordemOrigem];
      String keyOutra = keyList[ordemOutro];

      final collectionRef = _firestore.collection(QuestionarioModel.collection);

      final docOrigem = collectionRef.document(questionarioOrigem.id);
      final docOutro = collectionRef.document(questionarioOutro.id);

      docOrigem.setData({"ordem": questionarioOutro.ordem}, merge: true);
      docOutro.setData({"ordem": questionarioOrigem.ordem}, merge: true);
    }

    _validateData();
    if (!_stateController.isClosed) stateSink(_state);
    // print('>>> _state.escolhaMap <<< ${_state.escolhaMap}');
    print(
        'event.runtimeType em QuestionarioHomePageBloc  = ${event.runtimeType}');
  }
}

// List<QuestionarioModel> valuesList =
//     _state.questionarioMap.values.toList();
// final questionarioColl =
//     _firestore.collection(QuestionarioModel.collection);
// int ordem = 0;
// for (var questionario in valuesList) {
//   final docQuest = questionarioColl.document(questionario.id);
//   docQuest.setData({"ordem": ordem}, merge: true);
//   ordem += 1;
// }

// final eixoRef = _firestore.collection(EixoModel.collection);
// final docEixo = eixoRef.document(_state.eixoAtualID);
// docEixo.setData({"ultimaOrdemQuestionario": ordem}, merge: true);
