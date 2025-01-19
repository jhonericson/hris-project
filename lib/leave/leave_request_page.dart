import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hris_skripsi/constant/spacer_const.dart';
import 'package:hris_skripsi/core/enum.dart';
import '../constant/font_const.dart';
import '../widgets/button.dart';
import 'controller/leave_bloc.dart';

class LeaveRequestPage extends StatelessWidget {
  const LeaveRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaveBloc(),
      child: LeaveRequestPageView(),
    );
  }
}

class LeaveRequestPageView extends StatefulWidget {
  const LeaveRequestPageView({super.key});

  @override
  State<LeaveRequestPageView> createState() => _LeaveRequestPageViewState();
}

class _LeaveRequestPageViewState extends State<LeaveRequestPageView> {
  final List<String> cutiOptions = [
    'Ijin',
    'Cuti',
  ];
  String? cuti;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan Cuti'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dropdown untuk jenis cuti
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pilih Jenis Cuti',
              ),
              items: cutiOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                cuti = value;
              },
            ),
            const SizedBox(height: 16.0),

            // Input untuk memilih tanggal
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pilih Tanggal',
              ),
              readOnly: true,
              onTap: () async {
                // Tampilkan date picker
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                dateController.text =
                      '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';

                }
              },
            ),
            ksVertical15,
            TextFormField(
              controller: noteController,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              keyboardType: TextInputType.text,

              // onChanged: (value) {
              //   if (value.isNotEmpty) {
              //   } else if (emailValidatorRegExp.hasMatch(value)) {}
              //   return;
              // },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Note Kosong";
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

            // Tombol Ajukan Cuti
          ],
        ),
      ),
      bottomNavigationBar: BlocListener<LeaveBloc, LeaveState>(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ButtonGradient(
            height: kToolbarHeight,
            borderRadius: BorderRadius.circular(10),
            width: double.infinity,
            onPressed: () {
              if (cuti == null &&
                  dateController.text.isEmpty &&
                  noteController.text.isEmpty) {
                Fluttertoast.showToast(msg: 'Lengkapi data terlebih dahulu');
                return;
              } else {
                context.read<LeaveBloc>().add(
                      SubmitLeave(
                        startDate: dateController.text,
                        endDate: dateController.text,
                        leaveType: cuti?.toLowerCase() ?? "-",
                        notes: noteController.text,
                      ),
                    );
              }
            },
            child: Text(
              "Ajukan Cuti",
              style: kfWhite14Medium,
            ),
          ),
        ),
      ),
    );
  }
}
