part of 'login_page.dart';

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PrimaryTextField(
            labelText: 'Phone Number',
            hintText: 'Enter phone number',
            onChanged: getBloc<LoginBloc>(context).phoneNumberChanged,
            keyboardType: TextInputType.number,
            maxLength: 10,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: getBloc<LoginBloc>(context).sendOtpClicked,
          child: const Text('Go'),
        ),
      ],
    );
  }
}
