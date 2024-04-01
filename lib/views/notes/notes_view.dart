// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:test_proj/constants/routes.dart';
import 'package:test_proj/enums/menu_action.dart';
import 'package:test_proj/services/auth/auth_exceptions.dart';
import 'dart:developer' as devtools show log;

import 'package:test_proj/services/auth/auth_service.dart';
import 'package:test_proj/services/cloud/cloud_note.dart';
import 'package:test_proj/services/cloud/firebase_cloud_storage.dart';
import 'package:test_proj/services/crud/notes_service.dart';
import 'package:test_proj/utilities/dialogs/logout_dialog.dart';
import 'package:test_proj/views/notes/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;
  // ! does a force unwrap , because as the developer i made sure that
  // if the code reaches the notesview I do have a logged in user

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    // _notesService.open(); // no need added in notes service
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Notes'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    createOrUpdateNoteRoute,
                  );
                },
                icon: const Icon(Icons.add)),
            PopupMenuButton(
              onSelected: (value) async {
                devtools.log(value.toString());
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showlogOutDialog(context);
                    devtools.log(shouldLogout.toString());
                    if (shouldLogout) {
                      await AuthService.firebase().logOut();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                    }
                    break;
                  default:
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                      value: MenuAction.logout, child: Text('Log out'))
                ];
              },
            )
          ],
        ),
        body: StreamBuilder(
            stream: _notesService.allNotes(ownerUserId: userId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allNotes = snapshot.data as Iterable<CloudNote>;
                    // print(allNotes);
                    return NotesListView(
                      notes: allNotes,
                      onDeleteNote: (note) async {
                        await _notesService.deleteNote(
                            documentId: note.documentId);
                      },
                      onTap: (note) {
                        Navigator.of(context).pushNamed(
                          createOrUpdateNoteRoute,
                          arguments: note,
                        );
                      },
                    );

                    // return const Text('Got all the notes');
                  } else {
                    return const Text('No Note data');
                  }
                // for a stream we hook into the waiting state
                // for a future we hook into the done state (similar to promises in js)

                default:
                  return const CircularProgressIndicator();
              }
            }));
  }
}
