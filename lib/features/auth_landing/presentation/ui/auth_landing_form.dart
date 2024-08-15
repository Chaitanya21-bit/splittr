part of 'auth_landing_page.dart';

class _AuthLandingForm extends StatelessWidget {
  const _AuthLandingForm();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Lottie.asset(AnimationKeys.billLottie),
          AppFillButton(
            text: 'Quick Split',
            onTap: () {
              RouteHandler.push(context, RouteId.quickSplit);
            },
            fillColor: AppColors.blackColor,
            borderColor: AppColors.blackColor,
            textColor: AppColors.whiteColor,
          ),
          const SizedBox(
            height: 10,
          ),
          AppFillButton(
            text: 'Login',
            onTap: () {
              RouteHandler.push(context, RouteId.login);
            },
            fillColor: AppColors.denimColor,
            borderColor: AppColors.whiteColor,
            textColor: AppColors.whiteColor,
          ),
          const SizedBox(
            height: 10,
          ),
          AppFillButton(
            text: 'SignUp',
            onTap: () {
              RouteHandler.push(context, RouteId.signup);
            },
            fillColor: AppColors.whiteColor,
            borderColor: AppColors.whiteColor,
            textColor: AppColors.denimColor,
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
