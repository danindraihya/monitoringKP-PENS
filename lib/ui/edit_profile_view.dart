import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monitoring_kp_perusahaan/cubit/set_profile/set_profile_cubit.dart';
import 'package:monitoring_kp_perusahaan/ui/profile_view.dart';
import 'package:monitoring_kp_perusahaan/ui/widgets/input_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';

class EditProfile extends StatefulWidget {
  final String namaPembimbing;
  final String nipPembimbing;
  final String jabatanPembimbing;

  EditProfile(
      {this.namaPembimbing, this.nipPembimbing, this.jabatanPembimbing});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerNip = TextEditingController();
  TextEditingController controllerJabatan = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerNama.text = widget.namaPembimbing;
    controllerNip.text = widget.nipPembimbing;
    controllerJabatan.text = widget.jabatanPembimbing;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 41, 107, 1),
        title: Text("Edit Profile"),
      ),
      body: BlocConsumer<SetProfileCubit, SetProfileState>(
        listener: (context, setProfileState) {
          if (setProfileState is SetProfileSuccess) {
            Fluttertoast.showToast(msg: "Sukses update profile");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Profile();
            }));
          } else if (setProfileState is SetProfileFail) {
            Fluttertoast.showToast(msg: "Error saat melakukan input data.");
          }
        },
        builder: (context, setProfileState) {
          if (setProfileState is SetProfileProcess) {
            return SpinKitCircle(
              color: Colors.black,
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.all(5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: BorderSide(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InputData(
                              atribut: "Nama",
                              controller: controllerNama,
                              height: MediaQuery.of(context).size.height * 0.1,
                              maxLines: 2,
                            ),
                            InputData(
                              atribut: "NIP",
                              controller: controllerNip,
                              height: MediaQuery.of(context).size.height * 0.1,
                              maxLines: 2,
                            ),
                            InputData(
                              atribut: "Jabatan",
                              controller: controllerJabatan,
                              height: MediaQuery.of(context).size.height * 0.1,
                              maxLines: 2,
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: ButtonTheme(
                                  height: 30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      side: BorderSide(color: Colors.black)),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String namaPembimbing;
                                      String jabatanPembimbing;
                                      String nipPembimbing;

                                      if (controllerNama.text == "") {
                                        Fluttertoast.showToast(
                                            msg: "Harap isi data profile");
                                      } else {
                                        namaPembimbing = controllerNama.text;
                                        if (controllerJabatan.text == "") {
                                          jabatanPembimbing = "-";
                                        } else {
                                          jabatanPembimbing =
                                              controllerJabatan.text;
                                        }
                                        if (controllerNip.text == "") {
                                          nipPembimbing = "-";
                                        } else {
                                          nipPembimbing = controllerNip.text;
                                        }
                                        context
                                            .read<SetProfileCubit>()
                                            .setProfile(
                                                namaPembimbing,
                                                jabatanPembimbing,
                                                nipPembimbing,
                                                prefs.getString("idMahasiswa"));
                                      }
                                    },
                                    color: Color.fromRGBO(253, 184, 51, 1),
                                    child: Text("Ubah"),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
