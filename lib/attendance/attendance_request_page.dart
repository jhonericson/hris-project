import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hris_skripsi/constant/font_const.dart';
import 'package:hris_skripsi/core/enum.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/button.dart';
import 'location_bloc/location_bloc.dart';
import 'controller/attendance_bloc.dart';

class AttendanceRequestPage extends StatelessWidget {
  const AttendanceRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AttendanceBloc(),
        ),
        BlocProvider(
          create: (context) => LocationBloc()..add(GetLocation()),
        ),
      ],
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
  File? image;
  bool route = true;
  String? gdriveId;
  String? gdriveFile;
  late final dynamic bytes;
  late final TextEditingController _description;
  bool rotateMarkerLayerOptions = true;
  String? serviceError = '';
  // final _formKey = GlobalKey<FormState>();
  int interActiveFlags = InteractiveFlag.all;

  @override
  void initState() {
    // initLocationService();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Request'),
      ),
      body: Column(
        children: [
          BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationSuccess) {
                final location = state.location;

                String lat = "";
                String long = "";
                if (location.isNotEmpty) {
                  final loc = location.split(",");
                  if (loc.length > 1) {
                    lat = loc[0];
                    long = loc[1];
                  }
                }
                LatLng currentLatLng = LatLng(
                  double.parse(lat),
                  double.parse(long),
                );
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

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter:
                                LatLng(double.parse(lat), double.parse(long)),
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
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    color: Colors.grey,
                    height: 250,
                    child: Center(
                      child: Text("Please Wait..."),
                    )),
              );
            },
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
          if (state.actionStatus == ActionStatus.loading) {
            EasyLoading.show(
              status: "Please Wait...",
              dismissOnTap: true,
            );
          } else if (state.actionStatus == ActionStatus.success) {
            EasyLoading.showSuccess("success");
            EasyLoading.dismiss();
            Navigator.pop(context, "ok");
          } else if (state.actionStatus == ActionStatus.failure) {
            EasyLoading.showError("error");
            EasyLoading.dismiss();
          }
        },
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationSuccess) {
              final location = state.location;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                    } else if (location.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Lokasi tidak ditemukan",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    } else {
                      // print(
                      //     "${_description.text}, ${currentLatLng.latitude},${currentLatLng.longitude}");
                      getImage(
                          context: context,
                          source: ImageSource.camera,
                          lokasi: location,
                          note: _description.text);
                    }
                  },
                  child: Text(
                    "Ambil Gambar",
                    style: kfWhite14Medium,
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
