import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart run data_processing.dart <inputFile.csv>');
    exit(1);
  }
  final inputFile = args.first;
  final expenseByCategory = <String, double>{};
  double totalExpense = 0;
  final lines = File(inputFile).readAsLinesSync()..removeAt(0);
  for (final line in lines) {
    final values = line.split(',');
    final amountStr = values[0].replaceAll('"', '');
    final amount = double.parse(amountStr);
    final tag = values[1].replaceAll('"', '');
    final previousTotal = expenseByCategory[tag];
    previousTotal == null
        ? expenseByCategory[tag] = amount
        : expenseByCategory[tag] = previousTotal + amount;
    totalExpense += amount;
  }

  print('Total for all categories: ${totalExpense.toStringAsFixed(1)}h');
  for (final entry in expenseByCategory.entries) {
    final durationFormatted = entry.value.toStringAsFixed(1);
    final tag = entry.key == '' ? 'Unallocated' : entry.key;
    print('$tag: ${durationFormatted}UAH');
  }
  print('\n');
}
