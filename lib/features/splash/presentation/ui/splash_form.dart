part of 'splash_page.dart';

class _SplashForm extends StatelessWidget {
  const _SplashForm();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppImage(
        path: ImageAssets.splittrLogoDark,
      ),
    );
  }
}
