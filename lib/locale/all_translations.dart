import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> _supportedLanguages = ['en', 'fr'];
//Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class GlobalTranslations {
  Locale? _locale;
  Map<dynamic, dynamic>? _localizedValues;
  VoidCallback? _onLocaleChangedCallback;

  String frLang = "", enLang = "";
  Map<String, String> _cache = {};

  ///
  /// Returns the list of supported Locales
  ///
  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  ///
  /// Returns the translation that corresponds to the [key]
  ///
  String? text(String key) {
    return (_localizedValues == null || _localizedValues![key] == null)
        ? '** $key not found'
        : _localizedValues![key];
  }

  String? textWithContent(String key, {Map<String, dynamic>? values, num? plural, GlobalTranslationsGender? gender, }) {

    // [gender] and [plural] cannot be set at the same time
    assert((){
      if (gender != null && plural != null){
        throw FlutterError('gender and plural cannot be defined at the same time');
      }
      return true;
    }());

    //
    // Processes the template replacements if any
    //
    String? _processTemplate(String? template){
      if (values == null){
        return template;
      }

      String? output = template;

      values.forEach((String key, dynamic value){
        if (value != null && (value is String || value is num)){
          output = output!.replaceAll('{{$key}}', value.toString());
        }
      });

      return output;
    }

    // Return the requested string
    String? string = '** $key not found';

    if (_localizedValues != null) {
      // Check if the requested [key] is in the cache
      if (_cache[key] != null){
        return _processTemplate(_cache[key]);
      }

      // Iterate the key until found or not
      bool found = true;
      Map<dynamic, dynamic>? _values = _localizedValues;
      List<String> _keyParts = key.split('.');
      int _keyPartsLen = _keyParts.length;
      int index = 0;
      int lastIndex = _keyPartsLen - 1;

      while(index < _keyPartsLen && found){
        var value = _values![_keyParts[index]];

        if (value == null) {
          // Not found => STOP
          found = false;
          break;
        }

        // Check if we deal with plural or gender
        if ((plural != null || gender != null) && index == lastIndex && value is Map){
          if (plural != null){
            if (plural == 0 && value.containsKey("=0")){
              string = value["=0"];
              found = true;
            } else if (plural == 1 && value.containsKey("=1")){
              string = value["=1"];
              found = true;
            } else if (plural > 1 && value.containsKey(">1")){
              string = value[">1"];
              found = true;
            }
            if (found){
              break;
            }
          } else if (gender != null){
            if (gender == GlobalTranslationsGender.male && value.containsKey("male")){
              string = value["male"];
              found = true;
            } else if (gender == GlobalTranslationsGender.female && value.containsKey("female")){
              string = value["female"];
              found = true;
            } else if (gender == GlobalTranslationsGender.other && value.containsKey("other")){
              string = value["other"];
              found = true;
            }
          }
        }

        // Check if we found the requested key
        if (value is String && index == lastIndex){
          string = value;

          // Add to cache
          _cache[key] = string;
          break;
        }

        // go to next subKey
        _values = value;
        index++;
      }
    }
    return _processTemplate(string);
  }

  ///
  /// Returns the current language code
  ///
  get currentLanguage => _locale == null ? '' : _locale!.languageCode;

  ///
  /// Returns the current Locale
  ///
  get locale => _locale;

  ///
  /// One-time initialization
  ///
  Future<Null> init([String? language]) async {
    print(
        "init([String language]): language: $language, locale: ${_locale?.countryCode}");
    frLang = await rootBundle.loadString("assets/locale/i18n_fr.json");
    enLang = await rootBundle.loadString("assets/locale/i18n_en.json");
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  /// ----------------------------------------------------------
  /// Method that saves/restores the preferred language
  /// ----------------------------------------------------------
  //getPreferredLanguage() async {
  //  print("getPreferredLanguage");
  //  return _getApplicationSavedInformation('language');
  //}
//
  //setPreferredLanguage(String lang) async {
  //  print("setPreferredLanguage");
  //  return _setApplicationSavedInformation('language', lang);
  //}

  ///
  /// Routine to change the language
  ///
  setNewLanguage(
      [String? newLanguage, bool saveInPrefs = false]) {
    //Timer.periodic( Duration(seconds: 5), (timer) { timer.cancel();});
    print("setNewLanguage");
    String? language = newLanguage;
    //if (language == null) {
    //  language = await getPreferredLanguage();
    //}

    if(language==null) language='';

    print("language: $language");

    // Set the locale
    if (language == "") {
      language = "en";
    }
    print("language: $language");
    _locale = Locale(language, "");

    // Load the language strings
    //String jsonContent = await rootBundle
    //    .loadString("assets/locale/i18n_${_locale.languageCode}.json");
    String jsonContent = _locale!.languageCode == "fr" ? frLang : enLang;
    _localizedValues = json.decode(jsonContent);

    // If we are asked to save the new language in the application preferences
    //if (saveInPrefs) {
    //  await setPreferredLanguage(language);
    //}

    // If there is a callback to invoke to notify that a language has changed
    if (_onLocaleChangedCallback != null) {
      _onLocaleChangedCallback!();
    }

    return null;
  }

  ///
  /// Callback to be invoked when the user changes the language
  ///
  set onLocaleChangedCallback(VoidCallback callback) {
    print("onLocaleChangedCallback");
    _onLocaleChangedCallback = callback;
  }

  ///
  /// Application Preferences related
  ///
  /// ----------------------------------------------------------
  /// Generic routine to fetch an application preference
  /// ----------------------------------------------------------
  //Future<String> _getApplicationSavedInformation(String name) async {
  //  print("_getApplicationSavedInformation");
  //  final SharedPreferences prefs = await _prefs;
//
  //  return prefs.getString(_storageKey + name) ?? '';
  //}

  /// ----------------------------------------------------------
  /// Generic routine to saves an application preference
  /// ----------------------------------------------------------
  //Future<bool> _setApplicationSavedInformation(
  //    String name, String value) async {
  //  print("_setApplicationSavedInformation");
  //  final SharedPreferences prefs = await _prefs;
//
  //  return prefs.setString(_storageKey + name, value);
  //}

  ///
  /// Singleton Factory
  ///
  static final GlobalTranslations _translations =
      new GlobalTranslations._internal();
  factory GlobalTranslations() {
    print("_translations");
    return _translations;
  }
  GlobalTranslations._internal();
}

GlobalTranslations allTranslations = new GlobalTranslations();

enum GlobalTranslationsGender {
  male,
  female,
  other,
}

enum GlobalTranslationsNumberFormat {
  normal,
  currency,
  compact,
  compactCurrency,
  compactLong,
  compactSimpleCurrency,
  fixedNumberOfDecimals,
}