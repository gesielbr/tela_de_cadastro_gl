import 'package:dio/dio.dart';
import 'package:tela_de_cadastro_gl/endereco.dart';

class EnderecoService {
  Future<Endereco> getEdereco(String cep) async {
    var dio = Dio();
    var resposta = await dio.get('https://viacep.com.br/ws/$cep/json/');
    Endereco retorno;
    if (resposta.statusCode >= 200 && resposta.statusCode < 300) {
      retorno = Endereco.fromMap(resposta.data);
    } else {
      print(resposta.statusMessage);
    }
    return retorno;
  }
}
