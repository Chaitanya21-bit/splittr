part of 'otp_verification_page.dart';

class _OtpVerificationForm extends StatelessWidget {
  const _OtpVerificationForm();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OtpTextField(
            onChanged: getBloc<OtpVerificationBloc>(context).otpChanged,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Go'),
          ),
        ],
      ),
    );
  }
}
