import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:healty_apps/constant/font_const.dart';
import 'package:healty_apps/widgets/shadow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as lokasi;

import '../widgets/button.dart';

class AttendanceRequestPage extends StatefulWidget {
  const AttendanceRequestPage({super.key});

  @override
  State<AttendanceRequestPage> createState() => _AttendanceRequestPageState();
}

class _AttendanceRequestPageState extends State<AttendanceRequestPage> {
  late final MapController _mapController;
  lokasi.LocationData? _currentLocation;
  final lokasi.Location _locationService = lokasi.Location();
  File? image;
  bool route = true;
  String? gdriveId;
  String? gdriveFile;
  late final dynamic bytes;
  late final TextEditingController _description;
  final bool _liveUpdate = true;
  bool _permission = false;
  bool rotateMarkerLayerOptions = true;
  String? serviceError = '';
  // final _formKey = GlobalKey<FormState>();
  int interActiveFlags = InteractiveFlag.all;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _description = TextEditingController();
    initLocationService();
  }

  @override
  void dispose() {
    _description.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(
        source: source,
        maxHeight: 720,
        maxWidth: 720,
        requestFullMetadata: true);
    image = File(imagePicked!.path);
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: lokasi.LocationAccuracy.high,
      interval: 10000,
    );

    lokasi.LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        var permission = await _locationService.requestPermission();
        _permission = permission == lokasi.PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged
              .listen((lokasi.LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;
                if (_liveUpdate) {
                  _mapController.move(
                    LatLng(
                      _currentLocation!.latitude!,
                      _currentLocation!.longitude!,
                    ),
                    _mapController.camera.zoom,
                  );
                }
              });
            }
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        serviceError = e.message;
      }
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;
    var locationAccuracy = _currentLocation?.accuracy ?? 0.0;

    if (_currentLocation != null) {
      currentLatLng = LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      );
    } else {
      currentLatLng = const LatLng(0, 0);
    }
    var marker = <Marker>[
      Marker(
        width: 80,
        height: 80.0,
        point: currentLatLng,
        child: const Icon(
          Icons.location_on,
          size: 40.0,
          color: Colors.red,
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Request'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 250,
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(
                          currentLatLng.latitude, currentLatLng.longitude),
                      initialZoom: 16.5,
                      interactionOptions: InteractionOptions(
                        flags: interActiveFlags,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                      ),
                      MarkerLayer(markers: marker),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: PerfectShadow(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Accuration: ${locationAccuracy.toStringAsFixed(2)} m',
                              style: kfBlack10Bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              keyboardType: TextInputType.emailAddress,

              // onChanged: (value) {
              //   if (value.isNotEmpty) {
              //   } else if (emailValidatorRegExp.hasMatch(value)) {}
              //   return;
              // },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email Kosong";
                }
                return null;
              },
              decoration: InputDecoration(
                fillColor: Colors.black,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                labelText: "Catatan",
                hintText: "Tambahkan catatan",
                labelStyle: kfBlack14Regular.copyWith(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ButtonGradient(
          height: kToolbarHeight,
          borderRadius: BorderRadius.circular(10),
          width: double.infinity,
          onPressed: () {
            getImage(ImageSource.camera);
          },
          child: Text(
            "Ambil Gambar",
            style: kfWhite14Medium,
          ),
        ),
      ),
    );
  }
}
