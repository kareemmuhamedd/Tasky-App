import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/features/profile/repositories/profile_remote_repository.dart';
import 'package:tasky_app/features/profile/view/widgets/custom_profile_information_card.dart';
import 'package:tasky_app/features/profile/viewmodel/bloc/profile_bloc.dart';
import 'package:tasky_app/shared/networking/dio_factory.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';

import '../../../../shared/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        profileRemoteRepository: ProfileRemoteRepository(
          dio: DioFactory.getDio(),
        ),
      )..add(const ProfileDataRequested()),
      child: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isHaveActions: false,
        appBarTitle: 'Profile',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Icon(
                    CupertinoIcons.person_crop_circle_fill,
                    size: 100,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomProfileInformationCard(
                    cardTitle: 'NAME',
                    cardContent: state.user?.displayName ?? '',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomProfileInformationCard(
                    cardTitle: 'PHONE',
                    cardContent: state.user?.username ?? '',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomProfileInformationCard(
                    cardTitle: 'LEVEL',
                    cardContent: state.user?.level ?? '',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomProfileInformationCard(
                    cardTitle: 'YEARS OF EXPERIENCE',
                    cardContent: state.user?.experienceYears.toString() ?? '',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomProfileInformationCard(
                    cardTitle: 'LOCATION',
                    cardContent: state.user?.address ?? '',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
