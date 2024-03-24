import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/providers/locations.dart';

class AddLocationDialog extends ConsumerStatefulWidget {
  const AddLocationDialog({super.key});

  @override
  ConsumerState<AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends ConsumerState<AddLocationDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Location'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Name',
              icon: Icon(Icons.pin_drop),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (controller.text.isEmpty) return;
            ref
                .read(locationsProvider.notifier)
                .addWeatherByName(controller.text)
                .then((value) {
              if (!mounted) return;
              Navigator.of(context).pop();
            });
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
