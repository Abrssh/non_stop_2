import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "Group Unit Tests",
    () {
      test("First Unit test", () {
        int expectedNumber = 2;
        int expectedNumber2 = 4;

        int testNumber = 2;
        int testNumber2 = testNumber * 2;

        expect(expectedNumber, testNumber);
        expect(expectedNumber2, testNumber2);
      });

      test("Second Unit test", () {
        int expectedNumber = 5;

        expect(expectedNumber, 5);
      });
    },
  );
}
