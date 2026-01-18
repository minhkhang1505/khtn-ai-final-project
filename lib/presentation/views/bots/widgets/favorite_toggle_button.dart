import 'package:flutter/material.dart';

class FavoriteToggleButton extends StatefulWidget {
  final VoidCallback onFavoriteChanged;
  final bool initialIsFavorite;

  const FavoriteToggleButton({
    super.key,
    required this.onFavoriteChanged,
    this.initialIsFavorite = false,
  });

  @override
  State<FavoriteToggleButton> createState() => _FavoriteToggleButtonState();
}

class _FavoriteToggleButtonState extends State<FavoriteToggleButton> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialIsFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : colorScheme.onSurface,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
          widget.onFavoriteChanged.call();
        });
      },
    );
  }
}
