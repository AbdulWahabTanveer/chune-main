import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Useful_Code/widgets.dart';
import '../../auth_flow/app/bloc/app_bloc.dart';
import '../../auth_flow/delete_account/delete_account_cubit.dart';

class ManageAccount extends StatelessWidget {
  const ManageAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'chune',
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              InkWell(
                splashColor: Colors.white,
                onTap: () {
                  context.read<AppBloc>().add(AppLogoutRequested());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Log out'), Icon(Icons.exit_to_app)],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.white,
                onTap: () {
                  showConfirm(
                    context,
                    () async {
                      final userId = context.read<AppBloc>().state.user.id;

                      final result = await context
                          .read<DeleteAccountCubit>()
                          .deleteMyAccount(userId);

                      if (result != null) {
                        Fluttertoast.showToast(
                          msg: result,
                          toastLength: Toast.LENGTH_LONG,
                        );
                        return;
                      }
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Delete Account'), Icon(Icons.delete)],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  showConfirm(BuildContext context, VoidCallback onConfirm) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeightSpace(),
          const buttomSheetHeader(),
          const HeightSpace(20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('      Sure you want to Delete your account? 🙁'),
          ),
          ListTile(
            title: Text(
              'Yes',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: Icon(
              Icons.check,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.pop(context);
              onConfirm();
            },
          ),
          ListTile(
            title: Text(
              'No, cancel',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: Icon(
              Icons.close,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // const HeightSpace(40),
        ],
      ),
    );
  }
}
