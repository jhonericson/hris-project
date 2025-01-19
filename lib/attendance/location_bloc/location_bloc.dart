import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetLocation>(_onGetLocation);
  }

  Future<void> _onGetLocation(
    GetLocation event,
    Emitter<LocationState> emit,
  ) async {
    LocationSettings? locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
              "The app will continue to receive your location even when you aren't using it.",
          notificationTitle: "Location Running in Background",
          enableWakeLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    }

    try {
      emit(
        LocationLoading(),
      );

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw LocationServiceDisabledException();
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationPermissionDeniedException();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw LocationPermissionPermanentlyDeniedException();
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      emit(
        LocationSuccess(
          location: "${position.latitude},${position.longitude}",
        ),
      );
    } catch (e) {
      String errorMessage;
      if (e is LocationServiceDisabledException) {
        errorMessage = "Location services are disabled. Please enable them.";
      } else if (e is LocationPermissionDeniedException) {
        errorMessage = "Location permission is denied. Please enable it.";
      } else if (e is LocationPermissionPermanentlyDeniedException) {
        errorMessage =
            "Location permission is permanently denied. Please go to settings to enable it.";

        Future.delayed(
          const Duration(seconds: 3),
          () async {
            await Geolocator.openAppSettings();
          },
        );
      } else {
        errorMessage = "An unexpected error occurred: $e";
      }

      emit(
        LocationFailure(
          message: errorMessage,
        ),
      );
    }
  }
}

class LocationServiceDisabledException implements Exception {}

class LocationPermissionDeniedException implements Exception {}

class LocationPermissionPermanentlyDeniedException implements Exception {}
