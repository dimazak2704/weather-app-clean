// Перевірка напрямку залежностей: зовнішні шари залежать від
// внутрішніх, а не навпаки.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Усі import з файлів шару.
List<String> importsOf(String layer) {
  final pattern = RegExp(
    r"^import '([^']+)';",
    multiLine: true,
  );
  return Directory('lib/$layer')
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .expand(
        (file) => pattern
            .allMatches(file.readAsStringSync())
            .map((match) => match.group(1)!),
      )
      .toList();
}

/// Чи є import, який веде в заборонений шар.
List<String> forbidden(String layer, List<String> words) {
  return importsOf(layer)
      .where((path) => words.any(path.contains))
      .toList();
}

void main() {
  test(
    'Domain не залежить від інших шарів і від Flutter',
    () {
      expect(
        forbidden('domain', [
          'application/',
          'infrastructure/',
          'presentation/',
          'package:',
        ]),
        isEmpty,
      );
    },
  );

  test('Application залежить лише від Domain', () {
    expect(
      forbidden('application', [
        'infrastructure/',
        'presentation/',
        'package:',
      ]),
      isEmpty,
    );
  });

  test(
    'Infrastructure не знає про Application і Presentation',
    () {
      expect(
        forbidden('infrastructure', [
          'application/',
          'presentation/',
        ]),
        isEmpty,
      );
    },
  );

  test(
    'Presentation не бачить реалізацій Infrastructure',
    () {
      expect(
        forbidden('presentation', ['infrastructure/']),
        isEmpty,
      );
    },
  );
}
