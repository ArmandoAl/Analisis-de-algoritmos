//memorizacion
List<int>? bestSum(int targetSum, List<int> numbers,
    [Map<int, List<int>>? memo]) {
  memo = memo ?? {};
  if (memo.containsKey(targetSum)) return memo[targetSum];
  if (targetSum == 0) return [];
  if (targetSum < 0) return null;

  List<int> shortestCombination = [];

  for (var num in numbers) {
    var remainder = targetSum - num;
    var remainderCombination = bestSum(remainder, numbers, memo);
    if (remainderCombination != null) {
      var combination = List<int>.from(remainderCombination)..add(num);
      if (shortestCombination.isEmpty ||
          combination.length < shortestCombination.length) {
        shortestCombination = combination;
      }
    }
  }

  memo[targetSum] = shortestCombination;
  return shortestCombination;
}

// Tabulation
List<int> bestSumT(int targetSum, List<int> numbers) {
  //with tabulation
  List<List<int>> table = List.generate(targetSum + 1, (index) => []);
  table[0] = [];
  for (var i = 0; i <= targetSum; i++) {
    if (table[i].isNotEmpty) {
      for (var num in numbers) {
        var combination = List<int>.from(table[i])..add(num);
        if (i + num <= targetSum) {
          if (table[i + num].isEmpty ||
              combination.length < table[i + num].length) {
            table[i + num] = combination;
          }
        }
      }
    }
  }
  return table[targetSum];
}

void main() {
  print(bestSum(7, [5, 3, 4, 7])); // [7]
  print(bestSum(8, [2, 3, 5])); // [3, 5]
  print(bestSum(8, [1, 4, 5])); // [4, 4]
  print(bestSum(100, [1, 2, 5, 25])); // [25, 25, 25, 25]
  print(bestSumT(7, [5, 3, 4, 7])); // [7]
  print(bestSumT(8, [2, 3, 5])); // [3, 5]
  print(bestSumT(8, [1, 4, 5])); // [4, 4]
  print(bestSumT(100, [1, 2, 5, 25])); // [25, 25, 25, 25]
}
