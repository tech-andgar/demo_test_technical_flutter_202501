import 'package:demo_test_technical_flutter_202501/core/extensions/string_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtensions', () {
    test('capitalize() should capitalize the first letter', () {
      expect('hello'.capitalize(), 'Hello');
      expect('Hello'.capitalize(), 'Hello');
      expect('h'.capitalize(), 'H');
    });

    test('capitalize() should handle empty strings', () {
      expect(''.capitalize(), '');
    });

    test('titleCase() should capitalize the first letter of each word', () {
      expect('hello world'.titleCase(), 'Hello World');
      expect('one two three'.titleCase(), 'One Two Three');
      expect('ONE TWO THREE'.titleCase(), 'ONE TWO THREE');
    });

    test('titleCase() should handle empty strings', () {
      expect(''.titleCase(), '');
    });

    test('titleCase() should handle single word strings', () {
      expect('word'.titleCase(), 'Word');
    });

    test(
      'sentenceCase() should capitalize the first letter of each sentence',
      () {
        expect(
          'this is a sentence. and another one! is it?'.sentenceCase(),
          'This is a sentence. And another one! Is it?',
        );
        expect('one.two'.sentenceCase(), 'One.two');
        expect(
          '  leading spaces. and more'.sentenceCase(),
          'Leading spaces. And more',
        );
        expect(
          'already capitalized. sentence.'.sentenceCase(),
          'Already capitalized. Sentence.',
        );
      },
    );

    test('sentenceCase() should handle empty strings', () {
      expect(''.sentenceCase(), '');
    });
    test('sentenceCase() should handle single sentence', () {
      expect('single sentence.'.sentenceCase(), 'Single sentence.');
    });
  });
}
