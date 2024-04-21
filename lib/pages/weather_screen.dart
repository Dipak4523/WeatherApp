import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/network_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}
class _WeatherScreenState extends State<WeatherScreen> {
  final _locationController = TextEditingController();
  WeatherBloc? _weatherBloc;
  NetworkBloc? _networkBloc;

  @override
  Widget build(BuildContext context) {
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _networkBloc = BlocProvider.of<NetworkBloc>(context);
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            BlocBuilder<NetworkBloc, NetworkState>(
              bloc: _networkBloc?..add(NetworkObserve()),
              builder: (context, state) {
                if (state is NetworkFailure) {
                  return const Text("No Internet Connection",style: TextStyle(fontSize: 16,color: Colors.black),);
                } else if (state is NetworkSuccess) {
                  return const Text("You're Connected to Internet",style: TextStyle(fontSize: 16,color: Colors.black));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                hintText: "Enter location",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _weatherBloc?.add(GetWeather(location: _locationController.text));
              },
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                bloc: _weatherBloc,
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is WeatherLoaded) {
                    var weather = state.weather.weather?.first;
                    var weatherTemp = state.weather.weatherTemp;
                    var wind = state.weather.wind;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${(state.weather.name)},${state.weather.systemInfo?.country}",style: TextStyle(fontSize: 16),),
                        const SizedBox(height: 8),
                        Image.network('https://openweathermap.org/img/wn/${weather?.icon}@2x.png'),
                        const SizedBox(height: 8),
                        Text("${(weatherTemp?.temp?.toStringAsFixed(2))} \u2103"),
                        const SizedBox(height: 8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            designWeatherSubField('Feels like','${weatherTemp?.feelsLike} \u2103'),
                            designWeatherSubField('Humidity','${weatherTemp?.humidity}'),
                            designWeatherSubField('wind','${wind?.speed}'),
                          ],
                        )
                      ],
                    );
                  }
                  if (state is WeatherError) {
                    return Center(child: Text('${state.errorHandler.message}'));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget designWeatherSubField(String titleName,String value){
    return Row(
      mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titleName),
            SizedBox(width: 10,),
            Text(value),
          ],
    );
  }

  @override
  void dispose() {
    _weatherBloc?.close();
    super.dispose();
  }
}