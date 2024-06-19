import 'package:dekasut/helpers/prefs_helper.dart';
import 'package:dekasut/models/user_model.dart';
import 'package:dekasut/theme.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserModel? currentUser = PrefsHelper.instance.getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: _buildHeader(context),
      body: _buildContent(),
      resizeToAvoidBottomInset: false,
    );
  }

  AppBar _buildHeader(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: primaryTextColor),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: backgroundColor1,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Edit Profile',
        style: primaryTextStyle.copyWith(
          fontSize: 18,
          fontWeight: medium,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.check),
          color: primaryColor,
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(top: defaultMargin),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/image_profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildNameInput(),
          _buildUsernameInput(),
          _buildEmailInput(),
        ],
      ),
    );
  }

  Widget _buildNameInput() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: secondaryTextStyle.copyWith(fontSize: 13),
          ),
          TextFormField(
            style: primaryTextStyle,
            decoration: InputDecoration(
              hintText: currentUser?.name ?? 'Guest',
              hintStyle: primaryTextStyle,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: subtitleColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsernameInput() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username',
            style: secondaryTextStyle.copyWith(fontSize: 13),
          ),
          TextFormField(
            style: primaryTextStyle,
            decoration: InputDecoration(
              hintText: currentUser?.username ?? 'Guest',
              hintStyle: primaryTextStyle,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: subtitleColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email Address',
            style: secondaryTextStyle.copyWith(fontSize: 13),
          ),
          TextFormField(
            style: primaryTextStyle,
            decoration: InputDecoration(
              hintText: currentUser?.email ?? 'Guest',
              hintStyle: primaryTextStyle,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: subtitleColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
