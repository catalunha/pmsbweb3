import 'dart:convert';
import 'dart:io';
// import 'package:path_provider/path_provider.dart';

class SalvarBackupArquivosService {
  //TODO: VER NOVA FORMA DE SALVAR ARQUIVOS DE BACKUP
  // Public:
   static Future<File> salvarArquivoComoJsonNoStorage(dynamic object) {
  //   final fileJson = object.toMap();
  //   final datetime = _getDateTime();
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data["class"] = object.runtimeType.toString();
  //   data["datetime"] = datetime;
  //   data["id"] = object.id;
  //   data["data"] = fileJson;

  //   return _writeData(jsonEncode(data),
  //       object.runtimeType.toString() + '-_-' + datetime + '-_-' + object.id);
  }

  // // Private

  // static _getDateTime() {
  //   final dateTime = new DateTime.now();
  //   return dateTime.toString();
  // }

  // static Future<String> get _localPath async {
  //   final dir = await getExternalStorageDirectory();
  //   return dir.path;
  // }

  // static Future<File> _localFile(String fileName) async {
  //   final path = await _localPath;
  //   print('>>> path >>> ${path}');
  //   return File('$path/$fileName}.json');
  // }

  // static Future<File> _writeData(String data, String name) async {
  //   final file = await _localFile(name);
  //   return file.writeAsString('$data');
  // }
}
