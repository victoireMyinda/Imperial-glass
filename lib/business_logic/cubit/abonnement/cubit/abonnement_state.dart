part of 'abonnement_cubit.dart';


class AbonnementState {
  Map? field;
  AbonnementState({required this.field});
}

Map? initialState() {
  return {
    'id':"",
    'abonnementData':[],
    'paymentData':[],
    'prix':"",
    'duree':"",
    'counter': '10',
    'abonnement':'',
    'valueAbonnement':""
  };
}
