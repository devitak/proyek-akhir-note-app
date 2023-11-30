import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Profile Page"),
        centerTitle: true,
        backgroundColor: Color(0xffffa5a5),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    child: CircleAvatar(
                      radius: 78,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/devita.jpeg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Devita Khoirunnisa'i",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "NIM: 124210067 \nProdi: Sistem Informasi \nHobi: Makan",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoCondensed(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Profil Imelda
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    child: CircleAvatar(
                      radius: 78,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/imelda.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Imelda Insania Hutabarat",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "NIM: 124210009 \nProdi: Sistem Informasi \nHobi: Menyanyi dan Menonton",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoCondensed(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
