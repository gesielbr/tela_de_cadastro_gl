class Endereco {
  int numero;
  String rua;
  String bairro;
  String cidade;
  String uf;
  String pais;
  String cep;

  Endereco(
      {this.rua,
      this.bairro,
      this.cidade,
      this.uf,
      this.cep,
      this.pais,
      this.numero});

  Endereco.fromMap(Map<String, dynamic> endereco) {
    rua = endereco["logradouro"];
    bairro = endereco["bairro"];
    cidade = endereco["localidade"];
    uf = endereco["uf"];
  }
}
