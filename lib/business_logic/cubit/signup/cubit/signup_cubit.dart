import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState(field: initialState()));

  initForm() async {
    List universiteData = await SignUpRepository.getUniversiteData();
    emit(SignupState(field: {
      ...state.field!,
      "universiteData": universiteData,
    }));
  }

  loadFaculteData() async {
    List faculteData = await SignUpRepository.getFaculteData(
        idUniversite: state.field!["universite"]);
    emit(SignupState(field: {...state.field!, "faculteData": faculteData}));
  }

  loadDepartementData() async {
    List departementData = await SignUpRepository.getDepartementData(
        idFaculte: state.field!["faculte"]);
    emit(SignupState(
        field: {...state.field!, "departementData": departementData}));
  }

  loadPromotionData() async {
    List promotionData = await SignUpRepository.getPromotionData(
        idDepartement: state.field!["departement"]);
    emit(SignupState(field: {...state.field!, "promotionData": promotionData}));
  }

  loadProvinceData() async {
    List faculteData = await SignUpRepository.getFaculteData(
        idUniversite: state.field!["universite"]);
    emit(SignupState(field: {...state.field!, "faculteData": faculteData}));
  }

  initFormProvince() async {
    List provinceData = await SignUpRepository.getProvinceData();
    emit(SignupState(field: {
      ...state.field!,
      "provinceData": provinceData,
    }));
  }

  loadVilleData() async {
    List villeData = await SignUpRepository.getVilleData(
        idProvince: state.field!["province"]);
    emit(SignupState(field: {...state.field!, "villeData": villeData}));
  }

  loadEtablissementData() async {
    var response = await SignUpRepository.getEtablissementsKelasi();
    List? ecoleData = response["data"];
    emit(SignupState(field: {...state.field!, "ecoleData": ecoleData}));
  }

  loadLeveltData() async {
    var response = await SignUpRepository.getLevel();
    List? levelData = response["data"];
    emit(SignupState(field: {...state.field!, "levelData": levelData}));
  }

  loadSectionData() async {
    var response = await SignUpRepository.getSectionKelasi();
    List? sectionData = response["data"];
    emit(SignupState(field: {...state.field!, "sectionData": sectionData}));
  }

  loadOptionData() async {
    var response =
        await SignUpRepository.getOptionKelasi(state.field!["section"]);
    List? optionData = response["data"];
    emit(SignupState(field: {...state.field!, "optionData": optionData}));
  }

  loadCommuneData() async {
    List communeData =
        await SignUpRepository.getCommuneData(idVille: state.field!["ville"]);
    emit(SignupState(field: {...state.field!, "communeData": communeData}));
  }

  loadProvincesKelasi() async {
    var response = await SignUpRepository.getProvinceKelasi();
    int statusCode = response["status"];

    if (statusCode == 200) {
      List<Map<String, dynamic>> provincesDataKelasi = response["data"];
      emit(SignupState(field: {
        ...state.field!,
        "provinceDataKelasi": provincesDataKelasi,
      }));
    } else {
      print("erreur de l'obtention de data");
    }
  }

  loadVillesKelasi() async {
    var response =
        await SignUpRepository.getVilleKelasi(state.field!["province"]);
    List? villeDataKelasi = response["data"];
    emit(SignupState(field: {
      ...state.field!,
      "villeDataKelasi": villeDataKelasi,
    }));
  }

  loadCommunesKelasi() async {
    var response =
        await SignUpRepository.getCommuneKelasi(state.field!["ville"]);
    List? communeDataKelasi = response["data"];
    emit(SignupState(field: {
      ...state.field!,
      "communeDataKelasi": communeDataKelasi,
    }));
  }

  loadProductCream() async {
    var response = await SignUpRepository.gettAllProductCream();
    int statusCode = response["status"];

    if (statusCode == 200) {
      List productData = response["data"];
      emit(SignupState(field: {
        ...state.field!,
        "productData": productData,
      }));
    } else {
      print("erreur de l'obtention de data");
    }
  }

 loadVolumeCream() async {
    var response = await SignUpRepository.gettAllVolumeCream();
    int statusCode = response["status"];

    if (statusCode == 200) {
      List volumeData = response["data"];
      emit(SignupState(field: {
        ...state.field!,
        "volumeData": volumeData,
      }));
    } else {
      print("erreur de l'obtention de data");
    }
  }
  void updateField(context, {required String field, data}) {
    emit(SignupState(field: {
      ...state.field!,
      field: data,
    }));

    if (field == 'universite') {
      loadFaculteData();
    }

    if (field == 'province') {
      loadVillesKelasi();
    }
    if (field == 'ville') {
      loadCommunesKelasi();
    }

    if (field == 'section') {
      loadOptionData();
    }
  }
}
