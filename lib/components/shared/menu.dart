import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/profile/profile_cubit.dart';
import 'package:devameet_flutter/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Menu extends StatelessWidget {
  final int currentSelected;
  const Menu({super.key, required this.currentSelected});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => sl<ProfileCubit>()..loadUser(),
      child: Container(
        height: height * 0.0625,
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: DColors.secondary2, width: 0.5))),
        child: BottomNavigationBar(
            currentIndex: currentSelected,
            selectedFontSize: 0,
            elevation: 0,
            backgroundColor: DColors.primary3.withOpacity(0.03),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/home.svg"),
                  label: "",
                  activeIcon: SvgPicture.asset(
                    "assets/icons/home.svg",
                    color: DColors.primary3,
                  )),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/icons/door.svg"),
                  label: "",
                  activeIcon: SvgPicture.asset(
                    "assets/icons/door.svg",
                    color: DColors.primary3,
                  )),
              BottomNavigationBarItem(
                  icon: CircleAvatar(borderColor: DColors.grey3),
                  label: "",
                  activeIcon: CircleAvatar(borderColor: DColors.primary3)),
            ]),
      ),
    );
  }
}

class CircleAvatar extends StatelessWidget {
  final Color borderColor;

  const CircleAvatar({super.key, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Container(
          height: height * 0.04375,
          width: height * 0.04375,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DColors.white,
            border: Border.all(color: borderColor, width: 2),
            image: state.user != null ?
                DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/devameet/Avatar/${state.user?.avatar}_front.png")) : null
          ),
        );
      }
    );
  }
}
