import 'package:pmsbweb/bootstrap.dart';
import 'package:pmsbweb/models/base_model.dart';

class ChatNotificacaoModel extends FirestoreModel {
  static final String collection = "ChatNotificacao";
  String titulo;
  String texto;
  List<dynamic> usuario;
  dynamic enviada;

  ChatNotificacaoModel({String id, this.titulo, this.texto, this.usuario, this.enviada})
      : super(id);

  @override
  ChatNotificacaoModel fromMap(Map<String, dynamic> map) {
    // if (map.containsKey('enviada')) enviada = map['enviada'].toDate();
    if (map.containsKey('enviada')) enviada = map['enviada'];
    if (map.containsKey('titulo')) titulo = map['titulo'];
    if (map.containsKey('texto')) texto = map['texto'];
    if (map.containsKey('usuario')) usuario = map['usuario'];

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (titulo != null) data['titulo'] = this.titulo;
    if (texto != null) data['texto'] = this.texto;
    if (enviada != null) data['enviada'] = this.enviada.toUtc();
    if (usuario != null) data['usuario'] = this.usuario;
    return data;
  }

  Map<String, dynamic> toMapFirestore() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (titulo != null) data['titulo'] = this.titulo;
    if (texto != null) data['texto'] = this.texto;
    data['enviada'] = Bootstrap.instance.FieldValue.serverTimestamp();
    if (usuario != null) data['usuario'] = this.usuario;
    return data;
  }

}
