import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaconi/core/util/constants.dart';
import 'package:flaconi/core/util/date_utils.dart' as du;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/weather_model.dart';

class DaysListWidget extends StatelessWidget {
  final List<WeatherListItemData> list;
  final Function(int) onItemPressed;
  final int selectedIndex;

  const DaysListWidget({
    super.key,
    required this.list,
    required this.onItemPressed,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return DayListItem(
            item: list[index],
            isSelected: index == selectedIndex,
            onTap: () => onItemPressed(index),
          );
        },
      ),
    );
  }
}

class DayListItem extends StatelessWidget {
  final WeatherListItemData item;
  final bool isSelected;
  final VoidCallback onTap;

  const DayListItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isSelected
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2)
              : BorderSide.none,
        ),
        color: isSelected ? Colors.white.withOpacity(0.5) : Colors.white,
        child: Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                du.DateUtils.getDayName(item.dtTxt!).toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              CachedNetworkImage(
                imageUrl:
                    AppConstants.getIconUrl(item.weatherItemData?[0].icon),
                errorWidget: (_, __, ___) => const Icon(Icons.error),
                width: 40,
                height: 40,
              ),
              const SizedBox(height: 8),
              Text(
                "${item.mainItemData?.tempMin?.round() ?? "--"}° / ${item.mainItemData?.tempMax?.round() ?? "--"}°",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Text(
                "${DateFormat("HH:MM").format(DateTime.parse(item.dtTxt!))}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
