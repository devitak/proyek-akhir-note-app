import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_bucket/pages/kamera_page.dart';
import 'package:note_bucket/components/res/strings.dart';
import 'package:note_bucket/components/services/local_db.dart';
import 'package:note_bucket/components/views/create_note.dart';
import 'package:note_bucket/components/views/widgets/empty_view.dart';
import 'package:note_bucket/components/views/widgets/notes_grid.dart';
import 'package:note_bucket/components/views/widgets/notes_list.dart';
import 'package:note_bucket/pages/article_page.dart';
import 'profile_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.appName,
          style: GoogleFonts.poppins(fontSize: 24),
        ),
        backgroundColor: Color(0xffffa5a5),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isListView = !isListView;
              });
            },
            icon: Icon(
              isListView ? Icons.view_module : Icons.view_list,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xffffa5a5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                "Jangan lupa tulis agenda kamu hari ini disini yaa!",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: LocalDBService().listenAllNotes(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return EmptyView();
                  }
                  final notes = snapshot.data!;

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: isListView
                        ? NotesList(notes: notes)
                        : NotesGrid(notes: notes),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNoteView()));
        },
        backgroundColor: Colors.white,
        child: Image.asset(
          'assets/images/pensil.png',
          width: 24,
          height: 24,
          color: Colors.blue,
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomNavItem(
              Icons.home,
              'Home',
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeView()),
              ),
            ),
            _buildBottomNavItem(
              Icons.article,
              'Articles',
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArticlePage()),
              ),
            ),
            _buildBottomNavItem(
              Icons.camera,
              'Camera',
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KameraPage()),
              ),
            ),
            _buildBottomNavItem(
              Icons.account_circle,
              'Profile',
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              ),
            ),
            IconButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
