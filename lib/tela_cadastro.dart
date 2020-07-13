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
            Container(
              width: 150,
              height: 150,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                'https://scontent.fpoa8-1.fna.fbcdn.net/v/t1.0-9/73252289_2458474090873805_4609788411681701888_n.jpg?_nc_cat=111&_nc_sid=09cbfe&_nc_ohc=8-pBI7-_dg4AX-6ww6a&_nc_ht=scontent.fpoa8-1.fna&oh=0f6fd3847dfdcc7da24e34fd1661ed69&oe=5F2A3780',
              )),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
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
                          if (!EmailValidator.validate(email))
                            return 'por favor digite um email valido';
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
                            child: RaisedButton.icon(
                              padding: const EdgeInsets.all(8.0),
                              textColor: Colors.black,
                              onPressed: () async {
                                var busca = await enderecoService
                                    .getEdereco(_cepController.text);
                                _ruaController.text = busca.rua;
                                _bairroController.text = busca.bairro;
                                _cidadeController.text = busca.cidade;
                                _ufController.text = busca.uf;
                                _paisController.text = 'Brasil';
                              },
                              icon: Icon(Icons.search),
                              label: Text("Buscar CEP"),
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
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.black,
                    color: Colors.white,
                    onPressed: () {},
                    child: new Text("Limpar"),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.red,
                    onPressed: () {
                      _cpfController.text =
                          CnpjCpfBase.maskCpf(_cpfController.text);
                      if (_form.currentState.validate()) {
                        setState(() {
                          _form.currentState.save();
                        });
                      }

                      {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: Text('Dados: ${usuario.nome}'),
                              children: <Widget>[
                                //aqui vai outra bolinha
                                Center(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                      'https://scontent.fpoa8-1.fna.fbcdn.net/v/t1.0-9/73252289_2458474090873805_4609788411681701888_n.jpg?_nc_cat=111&_nc_sid=09cbfe&_nc_ohc=8-pBI7-_dg4AX-6ww6a&_nc_ht=scontent.fpoa8-1.fna&oh=0f6fd3847dfdcc7da24e34fd1661ed69&oe=5F2A3780',
                                    )),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: 20,
                                  ),
                                  child: Text(
                                    'Nome:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: 5,
                                  ),
                                  child: Text('${usuario.nome}'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: 10,
                                  ),
                                  child: Text(
                                    'Email:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: 5,
                                  ),
                                  child: Text('${usuario.email}'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: 10,
                                  ),
                                  child: Text(
                                    'CPF:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: 5,
                                  ),
                                  child: Text('${usuario.cpf}'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: 10,
                                  ),
                                  child: Text(
                                    'Email:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Text('${usuario.email}'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: 10,
                                  ),
                                  child: Text(
                                    'Endereço:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: 5,
                                  ),
                                  child: Text(
                                      '${usuario.endereco.rua}, ${usuario.endereco.numero}, ${usuario.endereco.bairro}, ${usuario.endereco.cidade}, ${usuario.endereco.pais}.'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      ;
                    },
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
