part of 'login_page.dart';

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: PrimaryTextField(
            labelText: 'Phone Number',
            hintText: 'Enter phone number',
            keyboardType: TextInputType.number,
            maxLength: 10,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            getBloc<LoginBloc>(context).sendOtpClicked('8401530399');
          },
          child: const Text('Go'),
        ),
      ],
    );
  }
}
