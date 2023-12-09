bool? canSum(int targetSum, List<int> numbers, [Map<int, bool>? memo]) {
  memo = memo ?? {};
  if (memo.containsKey(targetSum)) return memo[targetSum];
  if (targetSum == 0) return true;
  if (targetSum < 0) return false;

  for (var num in numbers) {
    var remainder = targetSum - num;
    if (canSum(remainder, numbers, memo) == true) {
      memo[targetSum] = true;
      return true;
    }
  }

  memo[targetSum] = false;
  return false;
}

void main() {
  print(canSum(7, [2, 3])); // true
  print(canSum(7, [5, 3, 4, 7])); // true
  print(canSum(7, [2, 4])); // false
  print(canSum(8, [2, 3, 5])); // true
  print(canSum(300, [7, 14])); // false
}
