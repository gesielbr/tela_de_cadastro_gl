import 'package:tela_de_cadastro_gl/endereco.dart';

class Usuario {
  String nome;
  String email;
  String cpf;

  Endereco endereco;

  Usuario() {
    endereco = Endereco();
  }
}
