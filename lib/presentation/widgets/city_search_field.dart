import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/city_notifier.dart';

/// Поле пошуку міста. Контролер тексту — локальний стан
/// цього віджета, тому він лишається у State.
class CitySearchField extends StatefulWidget {
  const CitySearchField({super.key});

  @override
  State<CitySearchField> createState() =>
      _CitySearchFieldState();
}

class _CitySearchFieldState extends State<CitySearchField> {
  final TextEditingController _controller =
      TextEditingController();

  @override
  void dispose() {
    // Контролер обов'язково звільняємо, інакше буде витік
    // пам'яті.
    _controller.dispose();
    super.dispose();
  }

  /// Передає назву міста в глобальний стан.
  void _submit(String value) {
    context.read<CityNotifier>().setCity(value);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      onSubmitted: _submit,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Введіть місто та натисніть Enter',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.north_east),
          tooltip: 'Застосувати',
          onPressed: () => _submit(_controller.text),
        ),
      ),
    );
  }
}
