class CloudStorageException implements Exception {
  const CloudStorageException();
}

// c
class CouldNotCreateNoteException implements CloudStorageException {}

// r
class CouldNotGetAllNotesException implements CloudStorageException {}

// u
class CouldNotUpdateNoteException implements CloudStorageException {}

// d
class CouldNotDeleteNoteException implements CloudStorageException {}
