import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_weather/models/weather_location.dart';
import 'package:intl/intl.dart';

class LocationCardTest extends ConsumerStatefulWidget {
  const LocationCardTest({
    super.key,
    required this.location,
    required this.index,
  });

  final WeatherLocation location;
  final int index;

  @override
  ConsumerState<LocationCardTest> createState() => _LocationCardTestState();
}

class _LocationCardTestState extends ConsumerState<LocationCardTest>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);
  final GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bool isLoadedForecast = widget.location.forecast != null;
    final bool isLoadedCond = widget.location.conditions != null;
    return Slidable(
      controller: controller,
      key: ValueKey(widget.index),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
            setState(() {});
          },
          closeOnCancel: true,
          confirmDismiss: () async {
            return await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Are you sure to dismiss?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                ) ??
                false;
          },
        ),
        children: [
          SlidableAction(
            autoClose: false,
            flex: 1,
            onPressed: (_) => controller
                .dismiss(ResizeRequest(Duration(milliseconds: 500), () {})),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.golf_course,
            label: 'Delete',
          ),
        ],
      ),
      child: _content(isLoadedForecast),
    );
  }

  Container _content(bool isLoadedForecast) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: widget.location.conditions?.first.type?.background ??
            const LinearGradient(colors: [Colors.red, Colors.blue]),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.location.isCurrent
                    ? 'My Location'
                    : widget.location.name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.grey.shade600, blurRadius: 10),
                  ],
                ),
              ),
              Text(
                DateFormat.Hm().format(DateTime.now()),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          if (isLoadedForecast)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () => controller.dismiss(
                        ResizeRequest(Duration(milliseconds: 500), () {})),
                    icon: Icon(
                      widget.location.conditions?.first.type?.icon ??
                          Icons.sync,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '${widget.location.forecast?.temp}°',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 40,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade600,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.location.conditions?.first.description ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade600,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          else
            const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
