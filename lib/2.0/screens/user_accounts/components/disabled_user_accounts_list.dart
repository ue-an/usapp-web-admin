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

class DisabledUserAccountsList extends StatefulWidget {
  Stream<List<Student>> streamAccounts;
  DisabledUserAccountsList({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.streamAccounts,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<DisabledUserAccountsList> createState() =>
      _DisabledUserAccountsListState();
}

class _DisabledUserAccountsListState extends State<DisabledUserAccountsList> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
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
          List<Student> disabledAccounts = [];
          snapshot.data.forEach((account) {
            if (account.isused == true && account.isEnabled == false) {
              disabledAccounts.add(account);
            }
          });
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: disabledAccounts.length,
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
                              .tappedDisabledAccount ==
                          disabledAccounts[index]) {
                        context
                            .read<UserAccountProvider>()
                            .changeTappedDisabledAccount = null;
                      } else {
                        // change student number value in provider
                        context
                                .read<UserAccountProvider>()
                                .changeTappedDisabledAccount =
                            disabledAccounts[index];
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
                        about: disabledAccounts[index].about,
                        college: disabledAccounts[index].college,
                        studentNumber: disabledAccounts[index].studentNumber,
                        firstName: disabledAccounts[index].firstName,
                        lastName: disabledAccounts[index].lastName,
                        mInitial: disabledAccounts[index].mInitial,
                        course: disabledAccounts[index].course,
                        yearLvl: disabledAccounts[index].yearLvl,
                        section: disabledAccounts[index].section,
                        isEnabled: disabledAccounts[index].isEnabled,
                        isused: disabledAccounts[index].isused,
                        email: disabledAccounts[index].email,
                        photo: disabledAccounts[index].photo,
                        deviceToken: disabledAccounts[index].deviceToken,
                      ),
                    ),
                  ),
                  context.watch<UserAccountProvider>().tappedDisabledAccount ==
                          disabledAccounts[index]
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
