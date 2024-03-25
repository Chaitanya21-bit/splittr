part of 'dashboard_page.dart';

class _DashboardForm extends StatelessWidget {
  const _DashboardForm();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Dashboard Page ${getBloc<GlobalBloc>(context).state.store.user}',
      ),
    );
  }
}
