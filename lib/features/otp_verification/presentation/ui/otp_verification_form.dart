part of 'otp_verification_page.dart';

class _OtpVerificationForm extends StatelessWidget {
  const _OtpVerificationForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OtpTextField(),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Go'),
        ),
      ],
    );
  }
}
