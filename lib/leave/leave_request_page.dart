import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hris_skripsi/constant/spacer_const.dart';

import '../constant/font_const.dart';
import '../home/navigation.dart';
import '../widgets/button.dart';

class LeaveRequestPage extends StatefulWidget {
  const LeaveRequestPage({super.key});

  @override
  State<LeaveRequestPage> createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final List<String> cutiOptions = ['Sakit', 'Cuti Tahunan', 'Cuti Melahirkan'];
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
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                }
              },
            ),
            ksVertical15,
            TextFormField(
              controller: noteController,
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

            // Tombol Ajukan Cuti
          ],
        ),
      ),
      bottomNavigationBar: Padding(
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavigation(),
                ),
              );
              Fluttertoast.showToast(
                  msg: "Success",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          child: Text(
            "Ajukan Cuti",
            style: kfWhite14Medium,
          ),
        ),
      ),
    );
  }
}
