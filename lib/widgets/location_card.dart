import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather_location.dart';
import 'package:intl/intl.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.location,
  });

  final WeatherLocation location;

  @override
  Widget build(BuildContext context) {
    final bool isLoaded = location.forecast != null;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: location.conditions?.first.type?.background ??
            const LinearGradient(colors: [Colors.red, Colors.blue]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location.isCurrent ? 'My Location' : location.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
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
          if (isLoaded)
            Column(
              children: [
                Text(
                  '${location.forecast?.temp}°',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 40,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.grey.shade600, blurRadius: 10),
                    ],
                  ),
                ),
                Text(
                  location.conditions?.first.description ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.grey.shade600, blurRadius: 10),
                    ],
                  ),
                )
              ],
            )
          else
            CircularProgressIndicator(),
        ],
      ),
    );
  }
}
