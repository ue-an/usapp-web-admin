import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/user_account_card.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/admin_provider.dart';
import 'package:web_tut/providers/user_account_provider.dart';
import 'package:web_tut/utils/constants.dart';

class ActiveUserAccountsList extends StatefulWidget {
  Stream<List<Student>> streamAccounts;
  ActiveUserAccountsList({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.streamAccounts,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<ActiveUserAccountsList> createState() => _ActiveUserAccountsListState();
}

class _ActiveUserAccountsListState extends State<ActiveUserAccountsList> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder(
          stream: widget.streamAccounts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Text('List of User Accounts'),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: UserAccountCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            streamAccounts: widget.streamAccounts,
          ),
          tablet: UserAccountCardGridView(
            streamAccounts: widget.streamAccounts,
          ),
          desktop: UserAccountCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            streamAccounts: widget.streamAccounts,
          ),
        ),
      ],
    );
  }
}

class UserAccountCardGridView extends StatefulWidget {
  Stream<List<Student>> streamAccounts;
  BuildContext context;
  UserAccountCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.streamAccounts,
    this.context,
  }) : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  @override
  State<UserAccountCardGridView> createState() =>
      _UserAccountCardGridViewState();
}

class _UserAccountCardGridViewState extends State<UserAccountCardGridView>
    with AutomaticKeepAliveClientMixin<UserAccountCardGridView> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  @override
  void initState() {
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext contexts) {
    return StreamBuilder<List<Student>>(
      stream: widget.streamAccounts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Student> activeAccounts = [];
          snapshot.data.forEach((account) {
            if (account.isused == true && account.isEnabled == true) {
              activeAccounts.add(account);
            }
          });
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: activeAccounts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: widget.childAspectRatio,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (context
                              .read<UserAccountProvider>()
                              .tappedActiveAccount ==
                          activeAccounts[index]) {
                        context
                            .read<UserAccountProvider>()
                            .changeTappedActiveAccount = null;
                      } else {
                        // change student number value in provider
                        context
                            .read<UserAccountProvider>()
                            .changeTappedActiveAccount = activeAccounts[index];
                      }

                      //add the student number to tapped list
                      // context
                      //     .read<UserAccountProvider>()
                      //     .addToTappedStudent(activeAccounts[index].studentNumber);
                      // print(context
                      //     .read<UserAccountProvider>()
                      //     .tappedActiveAccountsList);
                    },
                    child: UserAccountCard(
                      info: Student(
                        about: activeAccounts[index].about,
                        college: activeAccounts[index].college,
                        studentNumber: activeAccounts[index].studentNumber,
                        firstName: activeAccounts[index].firstName,
                        lastName: activeAccounts[index].lastName,
                        mInitial: activeAccounts[index].mInitial,
                        course: activeAccounts[index].course,
                        yearLvl: activeAccounts[index].yearLvl,
                        section: activeAccounts[index].section,
                        isEnabled: activeAccounts[index].isEnabled,
                        isused: activeAccounts[index].isused,
                        email: activeAccounts[index].email,
                        photo: activeAccounts[index].photo,
                        deviceToken: activeAccounts[index].deviceToken,
                      ),
                    ),
                  ),
                  context.watch<UserAccountProvider>().tappedActiveAccount ==
                          activeAccounts[index]
                      ? const Icon(Icons.check_box)
                      : Container()
                ],
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
