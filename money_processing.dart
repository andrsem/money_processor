import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart run money_processing.dart <inputFile.csv>');
    exit(1);
  }
  const currency = 'UAH';
  final inputFile = args.first;
  final expenseBy = <String, double>{};
  double totalExpense = 0;
  final lines = File(inputFile).readAsLinesSync()..removeAt(0);
  for (final line in lines) {
    final values = line.split(',');
    final amountStr = values[0].replaceAll('"', '');
    final amount = double.parse(amountStr);
    final category = values[1].replaceAll('"', '');
    final previousTotal = expenseBy[category];
    previousTotal == null
        ? expenseBy[category] = amount
        : expenseBy[category] = previousTotal + amount;
    totalExpense += amount;
  }
  print('\n');

  print('By categories:');
  for (final entry in expenseBy.entries) {
    final amountFormatted = entry.value.toStringAsFixed(1);
    final category = entry.key == '' ? 'Unallocated' : entry.key;
    print('$category: $amountFormatted $currency');
  }
  print('\n');
  print('Total: ${totalExpense.toStringAsFixed(1)} $currency');
  print('\n');
}
