import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:country_picker/country_picker.dart';

class TransAcademiaPhoneNumber extends StatefulWidget {
  const TransAcademiaPhoneNumber(
      {super.key,
      this.controller,
      this.color,
      this.hintText,
      this.validator,
      this.field,
      this.fieldValue,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? field;
  final String? fieldValue;
  @override
  // ignore: library_private_types_in_public_api
  _TransAcademiaPhoneNumberState createState() =>
      _TransAcademiaPhoneNumberState();
}

class _TransAcademiaPhoneNumberState extends State<TransAcademiaPhoneNumber> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.fieldValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return phoneForm(context, _controller, widget.field);

    // return TextField(
    //     keyboardType: TextInputType.number,
    //     inputFormatters: <TextInputFormatter>[
    //       LengthLimitingTextInputFormatter(9),
    //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    //     ],
    //     controller: _controller,
    //      onChanged: (value) {
    //       BlocProvider.of<SignupCubit>(context)
    //               .updateField(context, data: value.toString(), field: widget.field.toString());
    //      },
    //     decoration: InputDecoration(
    //       label: Text(
    //         "Numero de téléphone",
    //         style: TextStyle(
    //           color: Theme.of(context).backgroundColor,
    //         ),
    //       ),
    //       hintText: "XXX - XXX - XXX",
    //       // hintStyle: const TextStyle(color: Colors.black54),
    //       border: myinputborder(), //normal border
    //       enabledBorder: myfocusborder(context), //enabled border
    //       focusedBorder: myfocusborder(context), //focused border
    //       // set more border style like disabledBorder
    //     ));
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        // color: Colors.redAccent,
        width: 1,
      ));
}

OutlineInputBorder myfocusborder(context) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Theme.of(context).backgroundColor,
        width: 1,
      ));
}

Widget phoneForm(context, _controller, field) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).backgroundColor.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(10.0)),
    child: Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          // padding: const EdgeInsets.all(10.0),
          width: 90,
          padding: const EdgeInsets.only(bottom: 4.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(.1),
                width: 2,
              ),
            ),
          ),
          child: InkWell(
            onTap: () {
              // showCountryPicker(
              //   context: context,
              //   //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
              //   exclude: <String>['KN', 'MF'],
              //   favorite: <String>['CD'],
              //   //Optional. Shows phone code before the country name.
              //   showPhoneCode: true,
              //   onSelect: (Country country) {
              //     print('Select country: ${country.displayName}');
              //   },
              //   // Optional. Sets the theme for the country list picker.
              //   countryListTheme: CountryListThemeData(
              //     // Optional. Sets the border radius for the bottomsheet.
              //     borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(10.0),
              //       topRight: Radius.circular(10.0),
              //     ),
              //     searchTextStyle: Theme.of(context).textTheme.bodyText1,
              //     // Optional. Styles the search field.
              //     inputDecoration: const InputDecoration(
              //       hintText: "Entrez le nom du pays",
              //       prefixIcon: Icon(Icons.search, color: Colors.black87),
              //       border: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Colors.black87,
              //         ),
              //       ),
              //     ),
              //     backgroundColor: Colors.white,
              //     textStyle: Theme.of(context).textTheme.bodyText1,
              //     flagSize: 20,
              //   ),
              // );
            },
            child: Flex(
              direction: Axis.horizontal,
              children: const [
                Expanded(
                  child: Text(
                    '+243',
                    // style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    //       fontSize: 18,
                    //     ),
                  ),
                ),
                SizedBox(width: 10),
                Image(
                  image: AssetImage("assets/images/flag-trans.png"),
                  width: 30,
                )
                // const Icon(
                //   Icons.keyboard_arrow_down_rounded,
                //   size: 28,
                // ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            // padding: const EdgeInsets.all(10.0),
            // height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary.withOpacity(.1),
                  width: 2,
                ),
              ),
            ),
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      onChanged: (value) {
                        BlocProvider.of<SignupCubit>(context).updateField(
                            context,
                            data: value.toString(),
                            field: field.toString());
                      },
                      // keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(9),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: _controller,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: InputBorder.none,
                        hintText: "XXX XXX XXX",
                      ),
                      // style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      //       fontSize: 18,
                      //     ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Ink(
                  width: 40,
                  height: 40,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<SignupCubit>(context).updateField(context,
                          data: "", field: field.toString());
                          _controller.text = "";
                    },
                    borderRadius: BorderRadius.circular(100),
                    child:  Icon(
                      Icons.highlight_remove,
                      color:Theme.of(context).backgroundColor,
                      // color: Theme.of(context).colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
