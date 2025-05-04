import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaconi/core/util/constants.dart';
import 'package:flaconi/core/util/date_utils.dart' as du;
import 'package:flaconi/core/widgets/retry_widget.dart';
import 'package:flaconi/features/weather/presentation/widgets/data_row.dart';
import 'package:flaconi/features/weather/presentation/widgets/days_list_widget.dart';
import 'package:flaconi/features/weather/presentation/widgets/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(LoadWeather());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WeatherLoaded) {
            final selectedData = state.weather.weatherListItemData!.isNotEmpty
                ? state.weather.weatherListItemData![state.selectedIndex]
                : null;
            final fullDayName = du.DateUtils.getDayName(
                selectedData?.dtTxt! ?? "",
                isFullName: true);

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  fullDayName,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                centerTitle: true,
                actions: [
                  AppBarPopupMenu(
                    onUnitSelected: (value) {
                      if (value == 'switch_unit') {
                        context.read<WeatherBloc>().add(const ChangeUnit());
                      }
                    },
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<WeatherBloc>()
                      .add(LoadWeather(params: state.params));
                },
                child: selectedData == null
                    ? getRetryWidget("No Data Found")
                    : SizedBox(
                        height: double.maxFinite,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Text(
                                        state
                                                .weather
                                                .weatherListItemData![
                                                    state.selectedIndex]
                                                .weatherItemData?[0]
                                                .main
                                                ?.toUpperCase() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[800],
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 12),
                                      CachedNetworkImage(
                                        imageUrl: AppConstants.getIconUrl(
                                            selectedData
                                                .weatherItemData?[0].icon),
                                        height: 200,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "${selectedData.mainItemData?.temp}${state.temperatureUnitSymbol}",
                                        // Replace with actual temperature
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Card(
                                color: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      DataSpanText(
                                          text1: "Humidity",
                                          text2:
                                              "${selectedData.mainItemData?.humidity}%"),
                                      const Divider(),
                                      DataSpanText(
                                          text1: "Wind Speed",
                                          text2:
                                              "${selectedData.windItemData?.speed} ${state.windSpeedUnitSymbol}"),
                                      const Divider(),
                                      DataSpanText(
                                          text1: "Pressure",
                                          text2:
                                              "${selectedData.mainItemData?.pressure} hPa"),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "Upcoming Days",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(height: 8),
                              DaysListWidget(
                                list: state.weather.weatherListItemData!,
                                selectedIndex: state.selectedIndex,
                                onItemPressed: (index) {
                                  context
                                      .read<WeatherBloc>()
                                      .add(SelectDay(index));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            );
          }

          if (state is WeatherError) {
            return getRetryWidget(state.message);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget getRetryWidget(String message) {
    return RetryWidget(
        message: message,
        onRetry: () {
          context.read<WeatherBloc>().add(LoadWeather());
        });
  }
}
