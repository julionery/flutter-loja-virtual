import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future<void> editImage(String path) async {
      final File croppedFile = await ImageCropper.cropImage(
          sourcePath: path,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Editar Imagem',
              toolbarWidgetColor: Colors.white,
              toolbarColor: Theme.of(context).primaryColor),
          iosUiSettings: const IOSUiSettings(
              title: 'Editar Imagem',
              cancelButtonTitle: 'Cancelar',
              doneButtonTitle: 'Concluir'));

      if (croppedFile != null) {
        onImageSelected(croppedFile);
      }
    }

    Future<void> getImageByCamera() async {
      final PickedFile file = await picker.getImage(source: ImageSource.camera);
      if (file != null) editImage(file.path);
    }

    Future<void> getImageByGallery() async {
      final PickedFile file =
          await picker.getImage(source: ImageSource.gallery);
      if (file != null) editImage(file.path);
    }

    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              padding: const EdgeInsets.all(12),
              onPressed: getImageByCamera,
              child: const Text('Câmera'),
            ),
            FlatButton(
              padding: const EdgeInsets.all(12),
              onPressed: getImageByGallery,
              child: const Text('Galeria'),
            )
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o item'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: getImageByCamera,
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: getImageByCamera,
            child: const Text('Galeria'),
          )
        ],
      );
    }
  }
}
