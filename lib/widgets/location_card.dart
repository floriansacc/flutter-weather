import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/models/weather_location.dart';
import 'package:flutter_weather/providers/locations.dart';
import 'package:intl/intl.dart';

class LocationCard extends ConsumerStatefulWidget {
  const LocationCard({
    super.key,
    required this.location,
  });

  final WeatherLocation location;

  @override
  ConsumerState<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends ConsumerState<LocationCard> {
  final GlobalKey key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final bool isLoadedForecast = widget.location.forecast != null;
    final bool isLoadedCond = widget.location.conditions != null;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Dismissible(
        key: key,
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => ref
            .read(locationsProvider.notifier)
            .removeWeatherLocation(widget.location),
        background: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.red.shade300,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    size: 48,
                    color: Colors.white,
                  ),
                  Text(
                    'Delete',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        child: _content(isLoadedForecast),
      ),
    );
  }

  Container _content(bool isLoadedForecast) {
    return Container(
      // clipBehavior: Clip.hardEdge,
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
                  child: Icon(
                    widget.location.conditions?.first.type?.icon ?? Icons.sync,
                    size: 48,
                    color: Colors.white,
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
