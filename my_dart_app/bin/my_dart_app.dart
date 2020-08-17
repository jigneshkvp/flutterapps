abstract class Person {
  final String _name;

  Person.init(this._name);

  void printName() => print('The person name is $_name');
}



class Jignesh extends Person {
  Jignesh() : super.init('Jignesh');
}

void main(List<String> args) {
  var jp = Jignesh();
  jp.printName();
}
