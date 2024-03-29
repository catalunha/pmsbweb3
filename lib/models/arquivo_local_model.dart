import 'package:flutter_web/widgets.dart';
//import 'dart:io';

import 'dart:async';

class ArquivoLocalModel {
  String nome;
  String endereco;

  ArquivoLocalModel({@required this.nome, @required this.endereco});
}

class ArquivoLocalListModel {
  String extension(String path) => extension(path);

  Set<ArquivoLocalModel> _listaArquivos = Set<ArquivoLocalModel>();

  ArquivoLocalListModel();

  getListaAquivos() => _listaArquivos.toList();

  //funcao que vai converter de list para o formato que vai ser enviado ao firebase
  getListaFormatoFirebase() => null;

  getArquivoPorIndex(int index) => _listaArquivos.toList()[index];

  void removerArquivoLista(ArquivoLocalModel arquivo) {
    _listaArquivos.remove(arquivo);
  }

  void setNovasImagens(String imagepath) {
    String basename = imagepath.split("/").last;
    _listaArquivos
        .add(new ArquivoLocalModel(nome: basename, endereco: imagepath));
  }

  void setNovosArquivo(arquivoNovo) {
    //verificar se nao e nulo e entao retorna direcionar o dado de acordo com o tipo
    if (arquivoNovo != null) {
      _adicionarArquivosLista(arquivoNovo);
    }
  }

  void _adicionarArquivosLista(Map<String, String> arquivosNovos) {
    arquivosNovos.forEach((nome, endereco) => {
          _listaArquivos
              .add(new ArquivoLocalModel(nome: nome, endereco: endereco))
        });
  }

  // // pegar arquivo de um local do so
  // Future<File> localFile(String _localPath) async {
  //   final path = await _localPath;
  //   return File('$path');
  // }
}
