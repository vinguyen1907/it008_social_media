import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/screens/edit_profile/widget/update_button.dart';
import 'package:it008_social_media/screens/profile/my_profile_page.dart';
import 'package:it008_social_media/services/utils.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../services/storage_methods.dart';
import '../../utils/firebase_consts.dart';
import '../../utils/global_methods.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String address;
  const EditProfilePage({Key? key, required this.name, required this.address}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Uint8List? _image;
  bool _isLoading  = false;

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  final _editFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _userNameController = TextEditingController();
    var _regionController = TextEditingController();
    var _phoneController = TextEditingController();
    var _aboutController = TextEditingController();
    var _genderController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryTextColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Profile",
            style:
                AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
          ),
        ),
        body: SingleChildScrollView(
          child: LoadingManager(
            isLoading: _isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Form(
                key: _editFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    _image != null
                                        ? ClipOval(
                                            child: Image.memory(
                                              _image!,
                                              width: 67,
                                              height: 67,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : ClipOval(
                                            child: Image.network(
                                              'https://i.stack.imgur.com/l60Hf.png',
                                              width: 67,
                                              height: 67,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                    Positioned(
                                      left: 32,
                                      bottom: -14,
                                      child: IconButton(
                                        onPressed: selectImage,
                                        icon: SvgPicture.asset(
                                          height: 14,
                                          width: 16,
                                          AppAssets.icCamera,
                                          color: AppColors.primaryTextColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.name,
                                    style: AppStyles.postUserName
                                        .copyWith(fontSize: 18),
                                  ),
                                  Text(
                                    widget.address,
                                    style: AppStyles.postUserName
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Username",
                      style: AppStyles.postUserName
                          .copyWith(fontSize: 14, height: 21 / 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputWidget(
                      validatorText: "user name can't be Empty",
                      textEditingController: _userNameController,
                      maxLine: 1,
                      fillColor: AppColors.tetFieldColor,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Region",
                      style: AppStyles.postUserName
                          .copyWith(fontSize: 14, height: 21 / 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputWidget(
                      validatorText: "address can't be Empty",
                      textEditingController: _regionController,
                      maxLine: 1,
                      fillColor: AppColors.tetFieldColor,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone Number',
                                style: AppStyles.postUserName
                                    .copyWith(fontSize: 14, height: 21 / 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextInputWidget(

                                validatorText: "phone number name can't be Empty",
                                textEditingController: _phoneController,
                                maxLine: 1,
                                fillColor: AppColors.tetFieldColor,
                              ),
                            ],
                          ), //Container
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: AppStyles.postUserName
                                    .copyWith(fontSize: 14, height: 21 / 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextInputWidget(
                                textEditingController: _genderController,
                                validatorText: "Gender can't be Empty",
                                maxLine: 1,
                                fillColor: AppColors.tetFieldColor,
                              ),
                            ],
                          ), //Container
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "About",
                      style: AppStyles.postUserName
                          .copyWith(fontSize: 14, height: 21 / 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputWidget(
                      validatorText: "about name can't be Empty",
                      textEditingController: _aboutController,
                      maxLine: 3,
                      fillColor: AppColors.tetFieldColor,
                    ),
                    SizedBox(
                      height: 49,
                    ),
                    UpdateButton(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if(_editFormKey.currentState!.validate()){
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            final User? user = authInstance.currentUser;
                            final _uid = user!.uid;
                            if(_image != null){
                              String photoUrl =
                              await StorageMethods().uploadImageToStorage('posts', _image!, true);
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(_uid)
                                  .update({
                                'userName': _userNameController.text.toLowerCase().trim(),
                                'address': _regionController.text.toLowerCase().trim(),
                                'about': _aboutController.text.toLowerCase().trim(),
                                'gender': _genderController.text.toLowerCase().trim(),
                                'phone': _phoneController.text.toLowerCase().trim(),
                                'avatarImageUrl' : photoUrl,
                              });
                              Navigator.of(context).pop();
                            }else{
                              GlobalMethods.errorDialog(subtitle: 'please pick image', context: context);
                            }

                          } on FirebaseException catch (error) {
                            GlobalMethods.errorDialog(
                                subtitle: '${error.message}', context: context);
                            setState(() {
                              _isLoading = false;
                            });
                          } catch (error) {
                            GlobalMethods.errorDialog(subtitle: '$error', context: context);
                            setState(() {
                              _isLoading = false;
                            });
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        };
                        
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
