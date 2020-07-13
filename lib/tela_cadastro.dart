import 'package:flutter/material.dart';
import 'package:tela_de_cadastro_gl/services/endereco_service.dart';
import 'package:tela_de_cadastro_gl/usuario.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cnpj_cpf_helper/cnpj_cpf_helper.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _form = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _paisController = TextEditingController();
  final _ufController = TextEditingController();
  final usuario = Usuario();
  var enderecoService = EnderecoService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Formulário de Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          labelText: 'Nome completo',
                          focusColor: Colors.red,
                        ),
                        controller: _nomeController,
                        validator: (nome) {
                          if ((nome.length ?? 0) <= 3)
                            return 'Nome muito curto';
                          if ((nome.length ?? 0) >= 30)
                            return 'Nome muito longo';
                          return null;
                        },
                        onSaved: (nome) {
                          usuario.nome = nome;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          labelText: 'Email',
                          focusColor: Colors.red,
                        ),
                        controller: _emailController,
                        validator: (email) {
                          assert(EmailValidator.validate(email));
                          return null;
                        },
                        onSaved: (email) {
                          usuario.email = email;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          labelText: 'CPF',
                          focusColor: Colors.red,
                        ),
                        controller: _cpfController,
                        validator: (cpf) {
                          if (!CnpjCpfBase.isCpfValid(cpf))
                            return 'Por favor digite um cpf valido';
                          return null;
                        },
                        onSaved: (cpf) {
                          usuario.cpf = cpf;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                labelText: 'CEP',
                                focusColor: Colors.red,
                              ),
                              controller: _cepController,
                              validator: (cep) {
                                if (cep.length != 8)
                                  return 'Por favor digite um Cep valido';
                                return null;
                              },
                              onSaved: (cep) {
                                usuario.endereco.cep = cep;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: RaisedButton(
                              padding: const EdgeInsets.all(8.0),
                              textColor: Colors.red,
                              onPressed: () async {
                                var busca = await enderecoService
                                    .getEdereco(_cepController.text);
                                _ruaController.text = busca.rua;
                                _bairroController.text = busca.bairro;
                                _cidadeController.text = busca.cidade;
                                _ufController.text = busca.uf;
                                _paisController.text = 'Brasil';
                              },
                              child: new Text("Buscar"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                labelText: 'Rua',
                                focusColor: Colors.red,
                              ),
                              controller: _ruaController,
                              validator: (rua) {
                                if ((rua.length ?? 0) <= 3)
                                  return 'Nome da rua muito curto';
                                if ((rua.length ?? 0) >= 30)
                                  return 'Nome da rua muito longo';
                                return null;
                              },
                              onSaved: (rua) {
                                usuario.endereco.rua = rua;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                labelText: 'Numero',
                                focusColor: Colors.red,
                              ),
                              controller: _numeroController,
                              validator: (numero) {
                                if (int.tryParse(numero) == null)
                                  return 'Por favor digite apenas numeros';
                                return null;
                              },
                              onSaved: (numero) {
                                usuario.endereco.numero = int.tryParse(numero);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                labelText: 'Bairro',
                                focusColor: Colors.red,
                              ),
                              controller: _bairroController,
                              validator: (bairro) {
                                if ((bairro.length ?? 0) <= 3)
                                  return 'Nome do bairro muito curto';
                                if ((bairro.length ?? 0) >= 30)
                                  return 'Nome do bairro muito longo';
                                return null;
                              },
                              onSaved: (bairro) {
                                usuario.endereco.bairro = bairro;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                labelText: 'Cidade',
                                focusColor: Colors.red,
                              ),
                              controller: _cidadeController,
                              validator: (cidade) {
                                if ((cidade.length ?? 0) <= 3)
                                  return 'Nome da cidade muito curto';
                                if ((cidade.length ?? 0) >= 30)
                                  return 'Nome da cidade muito longo';
                                return null;
                              },
                              onSaved: (cidade) {
                                usuario.endereco.cidade = cidade;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                labelText: 'UF',
                                focusColor: Colors.red,
                              ),
                              controller: _ufController,
                              validator: (uf) {
                                if (uf.length != 2)
                                  return 'Estado invalido utilize apenas 2 caracetres';
                              },
                              onSaved: (uf) {
                                usuario.endereco.uf = uf;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                labelText: 'País',
                                focusColor: Colors.red,
                              ),
                              controller: _paisController,
                              validator: (pais) {
                                if (!(pais == 'Brasil' || pais == 'brasil'))
                                  return 'Nome do país inválido, por favor verifique';
                                return null;
                              },
                              onSaved: (pais) {
                                usuario.endereco.pais = pais;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.red,
                    onPressed: () {},
                    child: new Text("Limpar"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.red,
                    onPressed: () {},
                    child: new Text("Cadastrar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
