import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monitoring_kp_perusahaan/cubit/penilaian_kp/get_data_nilai/get_data_nilai_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/penilaian_kp/insert_data_nilai/insert_data_nilai_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/penilaian_kp/update_data_nilai/update_data_nilai_cubit.dart';
import 'package:monitoring_kp_perusahaan/ui/drawer.dart';
import 'package:monitoring_kp_perusahaan/ui/profile_view.dart';
import 'package:monitoring_kp_perusahaan/ui/widgets/row_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PenilaianKp extends StatefulWidget {
  @override
  _PenilaianKpState createState() => _PenilaianKpState();
}

class _PenilaianKpState extends State<PenilaianKp> {
  final TextEditingController controllerKehadiranMonitoring =
      TextEditingController();
  final TextEditingController controllerNilaiLaporan = TextEditingController();

  double kognitif1,
      kognitif2,
      kognitif3,
      kognitif4,
      kognitif5,
      afektif1,
      afektif2,
      afektif3,
      afektif4,
      afektif5,
      afektif6,
      afektif7,
      afektif8,
      psikomotorik1;

  @override
  void initState() {
    super.initState();

    kognitif1 = 0;
    kognitif2 = 0;
    kognitif3 = 0;
    kognitif4 = 0;
    kognitif5 = 0;
    afektif1 = 0;
    afektif2 = 0;
    afektif3 = 0;
    afektif4 = 0;
    afektif5 = 0;
    afektif6 = 0;
    afektif7 = 0;
    afektif8 = 0;
    psikomotorik1 = 0;

    context.read<GetDataNilaiCubit>().loadNilai();
    _checkData();
  }

  _checkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("namaPembimbingPerusahaan") == null ||
        prefs.getString("nipPembimbingPerusahaan") == null) {
      return Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Profile();
      }));
    }
  }

  // setSelectedRadio(int aspek, int nilai) {
  //   setState(() {
  //     print(aspek);
  //     print(nilai);
  //     aspek = nilai;
  //   });
  // }

  setKognitif1(double val) {
    setState(() {
      kognitif1 = val;
    });
  }

  setKognitif2(double val) {
    setState(() {
      kognitif2 = val;
    });
  }

  setKognitif3(double val) {
    setState(() {
      kognitif3 = val;
    });
  }

  setKognitif4(double val) {
    setState(() {
      kognitif4 = val;
    });
  }

  setKognitif5(double val) {
    setState(() {
      kognitif5 = val;
    });
  }

  setAfektif1(double val) {
    setState(() {
      afektif1 = val;
    });
  }

  setAfektif2(double val) {
    setState(() {
      afektif2 = val;
    });
  }

  setAfektif3(double val) {
    setState(() {
      afektif3 = val;
    });
  }

  setAfektif4(double val) {
    setState(() {
      afektif4 = val;
    });
  }

  setAfektif5(double val) {
    setState(() {
      afektif5 = val;
    });
  }

  setAfektif6(double val) {
    setState(() {
      afektif6 = val;
    });
  }

  setAfektif7(double val) {
    setState(() {
      afektif7 = val;
    });
  }

  setAfektif8(double val) {
    setState(() {
      afektif8 = val;
    });
  }

  setPsikomotorik(double val) {
    setState(() {
      psikomotorik1 = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 41, 107, 1),
        title: Text("Penilaian KP"),
      ),
      drawer: BaseDrawer(),
      body: BlocBuilder<GetDataNilaiCubit, GetDataNilaiState>(
        builder: (context, state) {
          if (state is GetDataNilaiSuccess) {
            return BlocConsumer<UpdateDataNilaiCubit, UpdateDataNilaiState>(
              listener: (context, updateNilaiState) {
                if (updateNilaiState is UpdateDataNilaiFail) {
                  Fluttertoast.showToast(msg: "Gagal update nilai");
                } else if (updateNilaiState is UpdateDataNilaiSuccess) {
                  Fluttertoast.showToast(msg: "Sukses update nilai");
                  setState(() {});
                }
              },
              builder: (context, updateNilaiState) {
                if (updateNilaiState is UpdateDataNilaiProcess) {
                  return SpinKitCircle(
                    color: Colors.black,
                  );
                }
                return BlocConsumer<InsertDataNilaiCubit, InsertDataNilaiState>(
                  listener: (context, insertDataNilaiState) {
                    if (insertDataNilaiState is InsertDataNilaiFail) {
                      Fluttertoast.showToast(msg: "Gagal input nilai");
                    } else if (insertDataNilaiState is InsertDataNilaiSuccess) {
                      Fluttertoast.showToast(msg: "Sukses input nilai");
                      setState(() {});
                    }
                  },
                  builder: (context, insertDataNilaiState) {
                    if (insertDataNilaiState is InsertDataNilaiProcess) {
                      return SpinKitCircle(
                        color: Colors.black,
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: BorderSide(color: Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Data Mahasiswa",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    RowData(
                                      atribut: "Nama",
                                      isi: state.namaMahasiswa,
                                    ),
                                    RowData(
                                      atribut: "NRP",
                                      isi: state.nrpMahasiswa,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Text(
                              "Komponen Penilaian",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            margin: EdgeInsets.all(3),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "A. Aspek Kognitif",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        )),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                          "1. Kemudahan untuk mengingat properti/peralatan yang dikenalkan/dipelajari"),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: kognitif1,
                                            onChanged: (value) {
                                              setKognitif1(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: kognitif1,
                                            onChanged: (value) {
                                              setKognitif1(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: kognitif1,
                                            onChanged: (value) {
                                              setKognitif1(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: kognitif1,
                                            onChanged: (value) {
                                              setKognitif1(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: kognitif1,
                                            onChanged: (value) {
                                              setKognitif1(value);
                                            }),
                                        Text("10")
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                          "2. Pemahaman tentang materi/tugas/pekerjaan yang diberikan"),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: kognitif2,
                                            onChanged: (value) {
                                              setKognitif2(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: kognitif2,
                                            onChanged: (value) {
                                              setKognitif2(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: kognitif2,
                                            onChanged: (value) {
                                              setKognitif2(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: kognitif2,
                                            onChanged: (value) {
                                              setKognitif2(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: kognitif2,
                                            onChanged: (value) {
                                              setKognitif2(value);
                                            }),
                                        Text("10")
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                          "3. Gagasan/Inisiatif/Inovasi dari materi/tugas/pekerjaan yang diberikan"),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: kognitif3,
                                            onChanged: (value) {
                                              setKognitif3(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: kognitif3,
                                            onChanged: (value) {
                                              setKognitif3(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: kognitif3,
                                            onChanged: (value) {
                                              setKognitif3(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: kognitif3,
                                            onChanged: (value) {
                                              setKognitif3(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: kognitif3,
                                            onChanged: (value) {
                                              setKognitif3(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                            "4. Kemampuan menganalisis permasalahan ")),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: kognitif4,
                                            onChanged: (value) {
                                              setKognitif4(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: kognitif4,
                                            onChanged: (value) {
                                              setKognitif4(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: kognitif4,
                                            onChanged: (value) {
                                              setKognitif4(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: kognitif4,
                                            onChanged: (value) {
                                              setKognitif4(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: kognitif4,
                                            onChanged: (value) {
                                              setKognitif4(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                          "5. Kemampuan menghadapi kesulitan/menyelesaikan permasalahan"),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: kognitif5,
                                            onChanged: (value) {
                                              setKognitif5(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: kognitif5,
                                            onChanged: (value) {
                                              setKognitif5(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: kognitif5,
                                            onChanged: (value) {
                                              setKognitif5(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: kognitif5,
                                            onChanged: (value) {
                                              setKognitif5(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: kognitif5,
                                            onChanged: (value) {
                                              setKognitif5(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            margin: EdgeInsets.all(3),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "B. Aspek Afektif",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        )),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "1. Kemampuan beradaptasi dengan lingkungan")),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: afektif1,
                                            onChanged: (value) {
                                              setAfektif1(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: afektif1,
                                            onChanged: (value) {
                                              setAfektif1(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: afektif1,
                                            onChanged: (value) {
                                              setAfektif1(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: afektif1,
                                            onChanged: (value) {
                                              setAfektif1(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: afektif1,
                                            onChanged: (value) {
                                              setAfektif1(value);
                                            }),
                                        Text("10")
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          "2. Kemampuan untuk bersosialisasi dengan lingkungan"),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: afektif2,
                                            onChanged: (value) {
                                              setAfektif2(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: afektif2,
                                            onChanged: (value) {
                                              setAfektif2(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: afektif2,
                                            onChanged: (value) {
                                              setAfektif2(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: afektif2,
                                            onChanged: (value) {
                                              setAfektif2(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: afektif2,
                                            onChanged: (value) {
                                              setAfektif2(value);
                                            }),
                                        Text("10")
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "3. Etika/Norma (pakaian, tingkah laku, pergaulan)")),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: afektif3,
                                            onChanged: (value) {
                                              setAfektif3(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: afektif3,
                                            onChanged: (value) {
                                              setAfektif3(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: afektif3,
                                            onChanged: (value) {
                                              setAfektif3(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: afektif3,
                                            onChanged: (value) {
                                              setAfektif3(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: afektif3,
                                            onChanged: (value) {
                                              setAfektif3(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                            "4. Kemampuan bekerjasama/ kerja kelompok")),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: afektif4,
                                            onChanged: (value) {
                                              setAfektif4(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: afektif4,
                                            onChanged: (value) {
                                              setAfektif4(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: afektif4,
                                            onChanged: (value) {
                                              setAfektif4(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: afektif4,
                                            onChanged: (value) {
                                              setAfektif4(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: afektif4,
                                            onChanged: (value) {
                                              setAfektif4(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text("5. Kedisiplinan")),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: afektif5,
                                            onChanged: (value) {
                                              setAfektif5(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: afektif5,
                                            onChanged: (value) {
                                              setAfektif5(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: afektif5,
                                            onChanged: (value) {
                                              setAfektif5(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: afektif5,
                                            onChanged: (value) {
                                              setAfektif5(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: afektif5,
                                            onChanged: (value) {
                                              setAfektif5(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text("6. Tanggung Jawab")),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: afektif6,
                                            onChanged: (value) {
                                              setAfektif6(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: afektif6,
                                            onChanged: (value) {
                                              setAfektif6(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: afektif6,
                                            onChanged: (value) {
                                              setAfektif6(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: afektif6,
                                            onChanged: (value) {
                                              setAfektif6(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: afektif6,
                                            onChanged: (value) {
                                              setAfektif6(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "7. Semangat dan kesungguhan dalam bekerja")),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: afektif7,
                                            onChanged: (value) {
                                              setAfektif7(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: afektif7,
                                            onChanged: (value) {
                                              setAfektif7(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: afektif7,
                                            onChanged: (value) {
                                              setAfektif7(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: afektif7,
                                            onChanged: (value) {
                                              setAfektif7(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: afektif7,
                                            onChanged: (value) {
                                              setAfektif7(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "8. Kemampuan dalam menyampaikan pendapat ")),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: afektif8,
                                            onChanged: (value) {
                                              setAfektif8(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: afektif8,
                                            onChanged: (value) {
                                              setAfektif8(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: afektif8,
                                            onChanged: (value) {
                                              setAfektif8(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: afektif8,
                                            onChanged: (value) {
                                              setAfektif8(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: afektif8,
                                            onChanged: (value) {
                                              setAfektif8(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            margin: EdgeInsets.all(3),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: BorderSide(color: Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "C. Aspek Psikomotorik",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "1. Kemampuan dan keterampilan dalam bekerja")),
                                    Row(
                                      children: <Widget>[
                                        Text("Skor: "),
                                        Radio(
                                            value: 6.0,
                                            groupValue: psikomotorik1,
                                            onChanged: (value) {
                                              setPsikomotorik(value);
                                            }),
                                        Text("6"),
                                        Radio(
                                            value: 7.0,
                                            groupValue: psikomotorik1,
                                            onChanged: (value) {
                                              setPsikomotorik(value);
                                            }),
                                        Text("7"),
                                        Radio(
                                            value: 8.0,
                                            groupValue: psikomotorik1,
                                            onChanged: (value) {
                                              setPsikomotorik(value);
                                            }),
                                        Text("8"),
                                        Radio(
                                            value: 9.0,
                                            groupValue: psikomotorik1,
                                            onChanged: (value) {
                                              setPsikomotorik(value);
                                            }),
                                        Text("9"),
                                        Radio(
                                            value: 10.0,
                                            groupValue: psikomotorik1,
                                            onChanged: (value) {
                                              setPsikomotorik(value);
                                            }),
                                        Text("10"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            margin: EdgeInsets.all(10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: BorderSide(color: Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "D. Kehadiran dan Laporan KP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "1. Kehadiran/Keaktifan Monitoring")),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1, child: Text("Skor : ")),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 30,
                                            child: TextField(
                                              maxLines: 1,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              controller:
                                                  controllerKehadiranMonitoring,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'(^\-?\d*\.?\d*)'))
                                              ],
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7))),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          "2. Nilai laporan (skala penilaian 0-10)"),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text("Skor : "),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 30,
                                              child: TextField(
                                                maxLines: 1,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    controllerNilaiLaporan,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'(^\-?\d*\.?\d*)'))
                                                ],
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7))),
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(25, 10, 10, 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Nilai Akhir",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text((state.totalNilaiAkhir == 0)
                                    ? "-"
                                    : state.totalNilaiAkhir.toString())
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
                              alignment: Alignment.topLeft,
                              child: Text("Rumus penilaian : ")),
                          Container(
                            margin: EdgeInsets.fromLTRB(25, 15, 25, 15),
                            child: Text(
                                " (0.25*0.2*A + 0.25*0.125*B + 0.15*C + 0.15*D1 + 0.2*D2)"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side: BorderSide(color: Colors.black)),
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (kognitif1 == 0 ||
                                        kognitif2 == 0 ||
                                        kognitif3 == 0 ||
                                        kognitif4 == 0 ||
                                        kognitif5 == 0 ||
                                        afektif1 == 0 ||
                                        afektif2 == 0 ||
                                        afektif3 == 0 ||
                                        afektif4 == 0 ||
                                        afektif5 == 0 ||
                                        afektif6 == 0 ||
                                        afektif7 == 0 ||
                                        afektif8 == 0 ||
                                        psikomotorik1 == 0 ||
                                        controllerKehadiranMonitoring.text ==
                                            "" ||
                                        controllerNilaiLaporan.text == "") {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Dimohon untuk mengisi seluruh penilaian.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          fontSize: 16.0);
                                    } else {
                                      if (double.parse(
                                                  controllerKehadiranMonitoring
                                                      .text) >
                                              10 ||
                                          double.parse(
                                                  controllerNilaiLaporan.text) >
                                              10) {
                                        Fluttertoast.showToast(
                                            msg: "Skala nilai antara 1 - 10");
                                      } else {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        List<double> nilai = [
                                          kognitif1,
                                          kognitif2,
                                          kognitif3,
                                          kognitif4,
                                          kognitif5,
                                          afektif1,
                                          afektif2,
                                          afektif3,
                                          afektif4,
                                          afektif5,
                                          afektif6,
                                          afektif7,
                                          afektif8,
                                          psikomotorik1,
                                          double.parse(
                                              controllerKehadiranMonitoring
                                                  .text),
                                          double.parse(
                                              controllerNilaiLaporan.text)
                                        ];
                                        if (state.totalNilaiAkhir == 0) {
                                          context
                                              .read<InsertDataNilaiCubit>()
                                              .submitNilai(
                                                  prefs
                                                      .getString("idMahasiswa"),
                                                  prefs.getString("idKpDaftar"),
                                                  nilai);
                                        } else {
                                          context
                                              .read<UpdateDataNilaiCubit>()
                                              .updateNilai(
                                                  prefs
                                                      .getString('idMahasiswa'),
                                                  nilai);
                                        }
                                      }
                                    }
                                  },
                                  color: Color.fromRGBO(253, 184, 51, 1),
                                  child: Text("Submit Penilaian KP"),
                                )),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return SpinKitCircle(
              color: Colors.black,
            );
          }
        },
      ),
    );
  }
}
