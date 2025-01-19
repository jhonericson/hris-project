import 'dart:convert';
import 'dart:typed_data';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hris_skripsi/constant/spacer_const.dart';
import 'package:hris_skripsi/core/enum.dart';
import 'package:latlong2/latlong.dart';
import 'package:photo_view/photo_view.dart';
import '../constant/font_const.dart';
import '../widgets/button.dart';
import 'controller/attendance_bloc.dart';

class AttendanceDetailPage extends StatelessWidget {
  final int id;
  final String source;
  const AttendanceDetailPage(
      {super.key, required this.id, required this.source});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc()..add(LoadAttendanceDetail(id: id)),
      child: AttendanceDetailPageView(
        id: id,
        source: source,
      ),
    );
  }
}

class AttendanceDetailPageView extends StatelessWidget {
  final int id;
  final String source;
  const AttendanceDetailPageView({
    super.key,
    required this.id,
    required this.source,
  }); // Catatan contoh

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lampiran Gambar:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            AttachmentWidget(),
            ksVertical20,
            MapsWidget(),
            ksVertical20,
            Text(
              'Tanggal Kehadiran:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state.listStatus == ListStatus.success) {
                  return Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          state.attendanceDetailModel?.result?.datetime ?? "-",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Loading...",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            ksVertical20,
            Text(
              'Catatan:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state.listStatus == ListStatus.success) {
                  return Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          state.attendanceDetailModel?.result?.notes ?? "-",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Loading...",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: BlocListener<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          print("${state.actionStatus} upi");
          if (state.actionStatus == ActionStatus.loading) {
            EasyLoading.show(
              status: "Please Wait...",
              dismissOnTap: true,
            );
            EasyLoading.dismiss();
            print("joko");
          } else if (state.actionStatus == ActionStatus.success) {
            EasyLoading.showSuccess("Success");
            EasyLoading.dismiss();
            Fluttertoast.showToast(
                msg: "Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context, "ok");
          } else if (state.actionStatus == ActionStatus.failure) {
            EasyLoading.showError("Failed");
            EasyLoading.dismiss();
          }
        },
        child: source == Source.approval.name
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonGradient(
                      height: kToolbarHeight,
                      borderRadius: BorderRadius.circular(10),
                      width: size.width * 0.4,
                      onPressed: () {
                        context.read<AttendanceBloc>().add(
                              RejectAttendance(
                                id: id,
                                status: "reject",
                              ),
                            );
                      },
                      child: Text(
                        "Reject",
                        style: kfWhite14Medium,
                      ),
                    ),
                    ButtonGradient(
                      height: kToolbarHeight,
                      borderRadius: BorderRadius.circular(10),
                      width: size.width * 0.4,
                      onPressed: () {
                        showOkCancelAlertDialog(
                          context: context,
                          title: 'Approve',
                          message: 'Are you sure to approve this request?',
                        ).then(
                          (value) {
                            if (value == OkCancelResult.ok) {
                              context.read<AttendanceBloc>().add(
                                    ApproveAttendance(
                                      id: id,
                                      status: "approve",
                                    ),
                                  );
                            }
                          },
                        );
                      },
                      child: Text(
                        "Approve",
                        style: kfWhite14Medium,
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ),
    );
  }
}

class AttachmentWidget extends StatelessWidget {
  const AttachmentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        if (state.listStatus == ListStatus.success) {
          final detail = state.attendanceDetailModel;
          Uint8List imageBytes = base64Decode(detail!.result!.attachment!);
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImageViewerPage(image: detail.result!.attachment!)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black)),
              height: 250,
              width: double.infinity,
              child: Image.memory(
                imageBytes,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black)),
            height: 250,
            width: double.infinity,
          );
        }
      },
    );
  }
}

class MapsWidget extends StatefulWidget {
  const MapsWidget({
    super.key,
  });

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  late final MapController _mapController;
  int interActiveFlags = InteractiveFlag.all;
  @override
  void initState() {
    // initLocationService();
    _mapController = MapController();

    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        if (state.listStatus == ListStatus.success) {
          final location =
              state.attendanceDetailModel?.result?.geolocation ?? "0,0";

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

          return Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black)),
            height: 200,
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
          );
        }
        return Container(
            color: Colors.grey,
            height: 200,
            child: Center(
              child: Text("Please Wait..."),
            ));
      },
    );
  }
}

// Image Viewer Page
class ImageViewerPage extends StatelessWidget {
  final String image;

  const ImageViewerPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: MemoryImage(base64Decode(image)),
          backgroundDecoration: BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
