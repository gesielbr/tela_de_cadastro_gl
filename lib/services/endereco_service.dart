import 'package:dio/dio.dart';
import 'package:tela_de_cadastro_gl/endereco.dart';

class EnderecoService {
  Future<Endereco> getEdereco(String cep) async {
    var dio = Dio();
    Endereco retorno;
    try {
      var resposta = await dio.get('https://viacep.com.br/ws/$cep/json/');

      retorno = Endereco.fromMap(resposta.data);
    } catch (e) {
      print('Erro tal');
    }

    return retorno;
  }
}
