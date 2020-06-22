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
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
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

    Future<void> getImage() async {
      final PickedFile file = await picker.getImage(source: ImageSource.camera);
      editImage(file.path);
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
              onPressed: getImage,
              child: const Text('Câmera'),
            ),
            FlatButton(
              padding: const EdgeInsets.all(12),
              onPressed: getImage,
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
            onPressed: getImage,
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: getImage,
            child: const Text('Galeria'),
          )
        ],
      );
    }
  }
}
