import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/post_bloc/post_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/view/camera_screen.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<File>? imageFiles;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ((context) => PostBloc(services: context.read<Services>())),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Builder(builder: (context) {
                  return IconButton(
                      icon: const Icon(
                        Icons.file_upload_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        BlocProvider.of<PostBloc>(context).add(
                            ImageFileChangeEvent(imageFiles: imageFiles ?? []));
                        BlocProvider.of<PostBloc>(context)
                            .add(PostToFirebaseEvent());
                        Navigator.pop(context);
                      });
                })
              ],
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      return _productName(context);
                    }),
                    const SizedBox(height: 10.0),
                    Builder(builder: (context) {
                      return _priceInput(context);
                    }),
                    const SizedBox(height: 10.0),
                    Builder(builder: (context) {
                      return _colorInput(context);
                    }),
                    const SizedBox(height: 10.0),
                    Builder(builder: (context) {
                      return _sizeInput(context);
                    }),
                    const SizedBox(height: 10.0),
                    Builder(builder: (context) {
                      return _productType(context);
                    }),
                    const SizedBox(height: 80.0),
                    Builder(builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              _buttomSheet(context);
                            },
                            child: const Text('Add image')),
                      );
                    }),
                  ],
                ))));
  }

  Container _productType(context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30)),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return DropdownButton<String>(
              value: BlocProvider.of<PostBloc>(context).state.catagory,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'cosmotics', child: Text('cosmotics')),
                DropdownMenuItem(
                  value: 'shoes',
                  child: Text('shoes'),
                ),
                DropdownMenuItem(
                  value: 'other',
                  child: Text('other'),
                ),
              ],
              onChanged: (choice) {
                BlocProvider.of<PostBloc>(context)
                    .add(CatagoryChangeEvent(catagory: choice ?? 'other'));
              });
        },
      ),
    );
  }

  TextField _sizeInput(BuildContext context) {
    return TextField(
      onChanged: (value) {
        BlocProvider.of<PostBloc>(context)
            .add(SizeChangeEvent(size: int.parse(value)));
      },
      decoration: InputDecoration(
          hintText: 'Available size',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide())),
    );
  }

  TextField _colorInput(BuildContext context) {
    return TextField(
      onChanged: (value) {
        BlocProvider.of<PostBloc>(context).add(ColorChangeEvent(color: value));
      },
      decoration: InputDecoration(
          hintText: 'Color',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide())),
    );
  }

  TextField _priceInput(BuildContext context) {
    return TextField(
      onChanged: (value) {
        BlocProvider.of<PostBloc>(context)
            .add(PriceChangeEvent(price: double.parse(value)));
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'price',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide())),
    );
  }

  TextField _productName(BuildContext context) {
    return TextField(
      onChanged: (value) {
        BlocProvider.of<PostBloc>(context)
            .add(ProductNameChangeEvent(productName: value));
      },
      decoration: InputDecoration(
          hintText: 'Name of the Product',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide())),
    );
  }

  void _buttomSheet(postcontext) {
    showModalBottomSheet(
        enableDrag: true,
        context: postcontext,
        builder: (postcontext) {
          return SizedBox(
            width: double.infinity,
            height: 122.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: const ListTile(
                    title: Text('Camera'),
                    leading: Icon(Icons.camera_alt_outlined),
                  ),
                  onTap: () {
                    availableCameras().then((cameras) async {
                      final camera = cameras.first;
                      Navigator.pop(context);
                      imageFiles = await Navigator.push(postcontext,
                          MaterialPageRoute(builder: ((context) {
                        return CameraScreen(camera: camera);
                      })));
                    });
                  },
                ),
                const SizedBox(height: 10),
                InkWell(
                  child: const ListTile(
                    title: Text('Gallery'),
                    leading: Icon(Icons.image),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final xImage = await _picker.pickMultiImage();
                    imageFiles = xImage!.map((e) => File(e.path)).toList();
                  },
                )
              ],
            ),
          );
        });
  }
}
