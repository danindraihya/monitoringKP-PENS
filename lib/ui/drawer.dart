import 'package:flutter/material.dart';
import 'package:monitoring_kp_perusahaan/ui/penilaian_kp_view.dart';
import 'package:monitoring_kp_perusahaan/ui/monitoring_kp_view.dart';
import 'package:monitoring_kp_perusahaan/ui/profile_view.dart';

class BaseDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Color.fromRGBO(0, 41, 107, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/profile.png'))),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    "Hello, Pembimbing Perusahaan",
                    maxLines: 3,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(Icons.person_outline_outlined),
            title: Text("Profile"),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Profile();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Monitoring KP'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MonitoringKpView();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_late_rounded),
            title: Text('Penilaian KP'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return PenilaianKp();
              }));
            },
          )
        ],
      ),
    );
  }
}
