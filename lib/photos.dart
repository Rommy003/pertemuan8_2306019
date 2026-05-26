import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/photo_provider.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PhotoProvider>().getPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PhotoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Foto'),
        backgroundColor: Colors.teal,
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(PhotoProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage.isNotEmpty) {
      return Center(child: Text(provider.errorMessage));
    }

    if (provider.photos.isEmpty) {
      return const Center(child: Text('Kosong'));
    }

    return ListView.builder(
      itemCount: provider.photos.length,
      itemBuilder: (context, index) {
        final photo = provider.photos[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                photo.thumbnailUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 50);
                },
              ),
            ),
            title: Text(
              photo.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text('ID: ${photo.id}'),
          ),
        );
      },
    );
  }
}
