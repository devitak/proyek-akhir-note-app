import 'dart:io';
import 'package:flutter/material.dart';
import 'picker.dart';

class KameraPage extends StatefulWidget {
  const KameraPage({Key? key}) : super(key: key);

  @override
  State<KameraPage> createState() => _KameraPageState();
}

class _KameraPageState extends State<KameraPage> {
  String _imagePath = "";
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ambil Fotomu!", style: TextStyle(fontSize: 20)),
        centerTitle: true,
        backgroundColor: Color(0xffffa5a5),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 16, // Tambahkan ruang vertikal di antara teks dan AppBar
            ),
            Container(
              child: Text(
                "Abadikan momenmu hari ini!",
                style: TextStyle(fontSize: 16, color: Colors.black), // Sesuaikan dengan warna teks AppBar
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _imagePickerHelper.getImageFromGallery((path) {
                  if (path != null) {
                    setState(() {
                      _imagePath = path;
                    });
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffffa5a5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Container(
                width: 200,
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.insert_drive_file_outlined),
                      SizedBox(width: 8),
                      Text("Pilih dari Galeri"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _imagePickerHelper.getImageFromCamera(
                      (path) => path != null ? setState(() => _imagePath = path) : null,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffffa5a5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Container(
                width: 200,
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      SizedBox(width: 8),
                      Text("Ambil dari Kamera"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Path: " + _imagePath),
            SizedBox(height: 16),
            _imagePath.isEmpty
                ? Container()
                : Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(File(_imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
