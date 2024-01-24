/// utility class
class Utils {
  static List<T> modelBuilder<M, T>(
          List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}

// rows
List<Student> data = [
  Student(name: 'Sarah', age: 19, role: 'Class Representative'),
  Student(name: 'Janine', age: 43, role: 'Professor'),
  Student(name: 'William', age: 27, role: 'Associate Professor')
];

// columns
List<String> columns = ['name', 'age', 'role'];

enum ProductColumns {
  productName,
  quantity,
  buyingPrice,
  sellingPrice,
}

class Student {
  final String name;
  final int age;
  final String role;
  bool isSelected;

  Student(
      {required this.name,
      required this.age,
      required this.role,
      this.isSelected = false});
}
