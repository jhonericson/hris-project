import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hris_skripsi/constant/font_const.dart';
import 'package:hris_skripsi/core/enum.dart';
import 'package:hris_skripsi/widgets/shadow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as lokasi;
import '../home/navigation.dart';
import '../widgets/button.dart';
import 'controller/attendance_bloc.dart';

class AttendanceRequestPage extends StatelessWidget {
  const AttendanceRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc(),
      child: const AttendanceRequestPageView(),
    );
  }
}

class AttendanceRequestPageView extends StatefulWidget {
  const AttendanceRequestPageView({super.key});

  @override
  State<AttendanceRequestPageView> createState() =>
      _AttendanceRequestPageViewState();
}

class _AttendanceRequestPageViewState extends State<AttendanceRequestPageView> {
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
    initLocationService();
    _mapController = MapController();
    _description = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _description.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> getImage({
    required BuildContext context,
    required ImageSource source,
    required String lokasi,
    required String note,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(
        source: source,
        maxHeight: 100,
        maxWidth: 100,
        requestFullMetadata: true);
    image = File(imagePicked!.path);
    if (image != null) {
      final byte = await image!.readAsBytes();
      final base64Image = base64Encode(byte);
      if (base64Image.isEmpty) {
        Fluttertoast.showToast(
            msg: "Gagal mengambil gambar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      } else {
        context.read<AttendanceBloc>().add(UploadAttendance(
              base64image: base64Image,
              location: lokasi,
              notes: note,
            ));
      }

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const BottomNavigation(),
      //   ),
      // );
      // Fluttertoast.showToast(
      //     msg: "Success",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: lokasi.LocationAccuracy.balanced,
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
          print("permission granted");
          location = await _locationService.getLocation();
          _currentLocation = location;
          print("$_currentLocation koko");
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
                        userAgentPackageName: 'com.hris.project',
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
              controller: _description,
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
                  return "catatan Kosong";
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
      bottomNavigationBar: BlocListener<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state.actionStatus==ActionStatus.loading) {
            EasyLoading.show(
              status: "Please Wait...",
              dismissOnTap: true,
            );
          } else if (state.actionStatus == ActionStatus.success) {
            EasyLoading.showSuccess("success");
            EasyLoading.dismiss();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(),
              ),
            );
          } else if (state.actionStatus == ActionStatus.failure) {
            EasyLoading.showError("error");
            EasyLoading.dismiss();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ButtonGradient(
            height: kToolbarHeight,
            borderRadius: BorderRadius.circular(10),
            width: double.infinity,
            onPressed: () {
              if (_description.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Catatan tidak boleh kosong",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
                return;
              }
              // else if (currentLatLng.latitude == 0 &&
              //     currentLatLng.longitude == 0) {
              //   Fluttertoast.showToast(
              //       msg: "Lokasi tidak ditemukan",
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.CENTER,
              //       timeInSecForIosWeb: 1,
              //       backgroundColor: Colors.black,
              //       textColor: Colors.white,
              //       fontSize: 16.0);
              //   return;
              // }
              else {
                print(
                    "${_description.text}, ${currentLatLng.latitude},${currentLatLng.longitude}");
                getImage(
                    context: context,
                    source: ImageSource.camera,
                    lokasi:
                        "${currentLatLng.latitude},${currentLatLng.longitude}",
                    note: _description.text);
              }
            },
            child: Text(
              "Ambil Gambar",
              style: kfWhite14Medium,
            ),
          ),
        ),
      ),
    );
  }
}
