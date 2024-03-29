// import 'package:pmsbweb/api/auth_api_mobile.dart';
// import 'package:pmsbweb/bootstrap.dart';
// import 'package:pmsbweb/models/upload_model.dart';
// import 'package:firestore_wrapper/firestore_wrapper.dart' as fw;
// import 'package:pmsbweb/state/auth_bloc.dart';
// import 'package:pmsbweb/state/upload_bloc.dart';
// import 'package:rxdart/rxdart.dart';

// class PageEvent {}

// class UpdateUsuarioIDEvent extends PageEvent {}

// class StartUserEvent extends PageEvent {}

// class StartUploadEvent extends PageEvent {
//   final String idUpload;

//   StartUploadEvent(this.idUpload);
// }

// class Uploading {
//   final String id;
//   final UploadModel upload;
//   bool uploading = false;

//   Uploading(this.upload, this.id);
// }

// class PageState {
//   List<Uploading> uploadingList;

//   Map<String, UploadBloc> uploading = Map<String, UploadBloc>();

// }

// class UploadPageBloc {
//   //Firestore
//   final fw.Firestore _firestore;
//   // Authenticacação
//   // final _authBloc = Bootstrap.instance.authBloc;
//   final _authBloc;
//   //Eventos
//   final _eventController = BehaviorSubject<PageEvent>();

//   Stream<PageEvent> get eventStream => _eventController.stream;
//   Function get eventSink => _eventController.sink.add;

//   //Estados
//   final PageState _state = PageState();
//   final _stateController = BehaviorSubject<PageState>();
//   Stream<PageState> get stateStream => _stateController.stream;
//   Function get stateSink => _stateController.sink.add;

//   // //ProdutoModel List
//   // final _uploadModelListController = BehaviorSubject<List<UploadModel>>();
//   // Stream<List<UploadModel>> get uploadModelListStream =>
//   //     _uploadModelListController.stream;
//   // Function get uploadModelListSink => _uploadModelListController.sink.add;

//   UploadPageBloc(this._firestore, this._authBloc) {
//     eventStream.listen(_mapEventToState);
//     // _authBloc.userId
//     //     .listen((userId) => eventSink(UpdateUsuarioIDEvent(userId)));
//   }

//   _mapEventToState(PageEvent event) async {
//     if (event is UpdateUsuarioIDEvent) {
//       _authBloc.userId.listen((userId) {
//         final streamDocs = _firestore
//             .collection(UploadModel.collection)
//             .where("usuario", isEqualTo: userId)
//             .where("upload", isEqualTo: false)
//             .snapshots()
//             .map((snapDocs) => snapDocs.documents
//                 .map((doc) => Uploading(
//                     UploadModel(id: doc.documentID).fromMap(doc.data),
//                     doc.documentID))
//                 .toList())
//             .listen((List<Uploading> uploadingList) {
//           _state.uploadingList = uploadingList;
//            _stateController.add(_state);
//         });
//       });
//     }
//     if (event is StartUploadEvent) {
//       _state.uploadingList?.forEach((up) {
//         if (up.id == event.idUpload) {
//           up.uploading = true;
//         }
//       });

//       final ref = _firestore
//           .collection(UploadModel.collection)
//           .document(event.idUpload);
//       _state.uploading[event.idUpload] =
//           UploadBloc(Bootstrap.instance.firestore);

//       final snap = await ref.get();
//       if (snap.exists) {
//         var uploadModel = UploadModel(id: snap.documentID).fromMap(snap.data);

//         final blocAtual = _state.uploading[event.idUpload];

//         blocAtual.uploadModelSink(uploadModel);

//         blocAtual.stateStream.listen((estado) {
//           if (estado.uploaded == true) {
//             blocAtual.dispose();
//             _state.uploading.remove(event.idUpload);
//           }
//         });
//       }

//     }

//     if (!_stateController.isClosed) _stateController.add(_state);
//     print(event.runtimeType);
//   }

//   void dispose() {
//     _stateController.close();
//     _eventController.close();
//     // _authBloc.dispose();
//   }
// }
