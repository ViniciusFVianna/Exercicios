import 'package:carrosflutter/models/carro.dart';

class CarrosApi {
  static List<Carro> getCarros() {
    final carros = List<Carro>();

    carros.add(Carro(
      nome: "Cadillac  Deville Convertible u2",
      tipo: "classicos",
      descricao: "Descrição Cadillac Deville Convertible",
      urlFoto:
          "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png",
    ));
    carros.add(Carro(
      nome: "Porsche Panamera",
      tipo: "esportivos",
      descricao: "Descrição Porsche Panamera",
      urlFoto:
          "http://www.livroandroid.com.br/livro/carros/esportivos/Porsche_Panamera.png",
    ));
    carros.add(Carro(
      nome: "Lamborghini Reventon3",
      tipo: "luxo",
      descricao: "Descrição Lamborghini Reventon",
      urlFoto:
          "http://www.livroandroid.com.br/livro/carros/luxo/Lamborghini_Reventon.png",
    ));

    return carros;
  }
}
