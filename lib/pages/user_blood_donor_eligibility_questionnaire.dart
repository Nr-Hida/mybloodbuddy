import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:mybb/components/my_button.dart";
import "package:mybb/components/my_textfield.dart";
import "package:mybb/components/yes_or_no.dart";
import "package:mybb/utils/enums.dart";

final db = FirebaseFirestore.instance;

class UserBloodDonorEligibilityQuestionnaire extends StatefulWidget {
  const UserBloodDonorEligibilityQuestionnaire({super.key});

  @override
  State<UserBloodDonorEligibilityQuestionnaire> createState() => _UserBloodDonorEligibilityQuestionnaireState();
}

class _UserBloodDonorEligibilityQuestionnaireState extends State<UserBloodDonorEligibilityQuestionnaire> {
  YesOrNo _feelingWellToday = YesOrNo.unanswered;
  YesOrNo _donatingToTestForHIV = YesOrNo.unanswered;
  YesOrNo _donatedBefore = YesOrNo.unanswered;
  YesOrNo _anyProblemsDuringOrAfterDonated = YesOrNo.unanswered;
  YesOrNo _takingAnyMeds = YesOrNo.unanswered;
  YesOrNo _sufferedFeverColdCough = YesOrNo.unanswered;
  YesOrNo _attackedByHeadacheMigraine = YesOrNo.unanswered;
  YesOrNo _seekedMedAttention = YesOrNo.unanswered;
  YesOrNo _jaundice = YesOrNo.unanswered;
  YesOrNo _drycough = YesOrNo.unanswered;
  YesOrNo _HepBOrHepC = YesOrNo.unanswered;
  YesOrNo _diabetes = YesOrNo.unanswered;
  YesOrNo _hiv = YesOrNo.unanswered;
  YesOrNo _hbp = YesOrNo.unanswered;
  YesOrNo _std = YesOrNo.unanswered;
  YesOrNo _heartDiseases = YesOrNo.unanswered;
  YesOrNo _malaria = YesOrNo.unanswered;
  YesOrNo _mentalIllnesses = YesOrNo.unanswered;
  YesOrNo _kidneyDiseases = YesOrNo.unanswered;
  YesOrNo _epilepsy = YesOrNo.unanswered;
  YesOrNo _asthma = YesOrNo.unanswered;
  YesOrNo _others = YesOrNo.unanswered;
  YesOrNo _hepBHepC = YesOrNo.unanswered;
  YesOrNo _undergoneSurgery = YesOrNo.unanswered;
  YesOrNo _receivedBloodTransfusion = YesOrNo.unanswered;
  YesOrNo _gotAccidentalNeedleStickInjury = YesOrNo.unanswered;
  YesOrNo _receivedImmunizationShotOrBeautyInjection = YesOrNo.unanswered;
  YesOrNo _hadDentalTreatment = YesOrNo.unanswered;
  YesOrNo _piercingsTattoosCuppingAcupuncture = YesOrNo.unanswered;
  YesOrNo _hadADrinkLast24Hours = YesOrNo.unanswered;
  YesOrNo _humanGrowthHormoneInjection = YesOrNo.unanswered;
  YesOrNo _corneaTransplant = YesOrNo.unanswered;
  YesOrNo _brainMembraneTransplant = YesOrNo.unanswered;
  YesOrNo _boneMarrowOrStemCellsTransplant = YesOrNo.unanswered;
  YesOrNo _visitedOrResidedvCJDCountries = YesOrNo.unanswered;
  YesOrNo _bloodTransfusionOrInjectionInTheUK = YesOrNo.unanswered;
  YesOrNo _visitedOrResidedInEuropeanCountries = YesOrNo.unanswered;
  YesOrNo _hadGaySex = YesOrNo.unanswered;
  YesOrNo _hadSexWithPro = YesOrNo.unanswered;
  YesOrNo _hadPaidOrReceivedPaymentForSex = YesOrNo.unanswered;
  YesOrNo _hadMoreThanOneSexPartner = YesOrNo.unanswered;
  YesOrNo _hadNewSexPartnerLast12Months = YesOrNo.unanswered;
  YesOrNo _injectedIllegalDrugs = YesOrNo.unanswered;
  YesOrNo _sexPartnerIncludedInAnyCategoryAbove = YesOrNo.unanswered;
  YesOrNo _testedPositiveForHIV = YesOrNo.unanswered;
  YesOrNo _thinkTestedPositiveForHIV = YesOrNo.unanswered;
  YesOrNo _onPeriod = YesOrNo.unanswered;
  YesOrNo _pregoOrMaybePrego = YesOrNo.unanswered;
  YesOrNo _haveBreastFeedingChild = YesOrNo.unanswered;
  YesOrNo _givenBirthOrHadMiscarriageLast6Months = YesOrNo.unanswered;

  // Controllers
  final _problemsDonatingController = TextEditingController();
  final _takeAnyMedsController = TextEditingController();
  final _seekedMedAttentionController = TextEditingController();
  final _otherDiseasesController = TextEditingController();
  final _relationToHepBCController = TextEditingController();
  final _typeOfImmunizationShotOrBeautyShotController = TextEditingController();

  // No other way, I'm afraid
  void stateSetter1(YesOrNo? value) { setState(() { _feelingWellToday = value as YesOrNo; }); }
  void stateSetter2(YesOrNo? value) { setState(() { _donatingToTestForHIV = value as YesOrNo; }); }
  void stateSetter3(YesOrNo? value) { setState(() { _donatedBefore = value as YesOrNo; }); }
  void stateSetter4(YesOrNo? value) { setState(() { _anyProblemsDuringOrAfterDonated = value as YesOrNo; }); }
  void stateSetter5(YesOrNo? value) { setState(() { _takingAnyMeds = value as YesOrNo; }); }
  void stateSetter6(YesOrNo? value) { setState(() { _sufferedFeverColdCough = value as YesOrNo; }); }
  void stateSetter7(YesOrNo? value) { setState(() { _attackedByHeadacheMigraine = value as YesOrNo; }); }
  void stateSetter8(YesOrNo? value) { setState(() { _seekedMedAttention = value as YesOrNo; }); }
  void stateSetter9(YesOrNo? value) { setState(() { _jaundice = value as YesOrNo; }); }
  void stateSetter10(YesOrNo? value) { setState(() { _drycough = value as YesOrNo; }); }
  void stateSetter11(YesOrNo? value) { setState(() { _HepBOrHepC = value as YesOrNo; }); }
  void stateSetter12(YesOrNo? value) { setState(() { _diabetes = value as YesOrNo; }); }
  void stateSetter13(YesOrNo? value) { setState(() { _hiv = value as YesOrNo; }); }
  void stateSetter14(YesOrNo? value) { setState(() { _hbp = value as YesOrNo; }); }
  void stateSetter15(YesOrNo? value) { setState(() { _std = value as YesOrNo; }); }
  void stateSetter16(YesOrNo? value) { setState(() { _heartDiseases = value as YesOrNo; }); }
  void stateSetter17(YesOrNo? value) { setState(() { _malaria = value as YesOrNo; }); }
  void stateSetter18(YesOrNo? value) { setState(() { _mentalIllnesses = value as YesOrNo; }); }
  void stateSetter19(YesOrNo? value) { setState(() { _kidneyDiseases = value as YesOrNo; }); }
  void stateSetter20(YesOrNo? value) { setState(() { _epilepsy = value as YesOrNo; }); }
  void stateSetter21(YesOrNo? value) { setState(() { _asthma = value as YesOrNo; }); }
  void stateSetter22(YesOrNo? value) { setState(() { _others = value as YesOrNo; }); }
  void stateSetter23(YesOrNo? value) { setState(() { _hepBHepC = value as YesOrNo; }); }
  void stateSetter24(YesOrNo? value) { setState(() { _undergoneSurgery = value as YesOrNo; }); }
  void stateSetter25(YesOrNo? value) { setState(() { _receivedBloodTransfusion = value as YesOrNo; }); }
  void stateSetter26(YesOrNo? value) { setState(() { _gotAccidentalNeedleStickInjury = value as YesOrNo; }); }
  void stateSetter27(YesOrNo? value) { setState(() { _receivedImmunizationShotOrBeautyInjection = value as YesOrNo; }); }
  void stateSetter28(YesOrNo? value) { setState(() { _hadDentalTreatment = value as YesOrNo; }); }
  void stateSetter29(YesOrNo? value) { setState(() { _piercingsTattoosCuppingAcupuncture = value as YesOrNo; }); }
  void stateSetter30(YesOrNo? value) { setState(() { _hadADrinkLast24Hours = value as YesOrNo; }); }
  void stateSetter31(YesOrNo? value) { setState(() { _humanGrowthHormoneInjection = value as YesOrNo; }); }
  void stateSetter32(YesOrNo? value) { setState(() { _corneaTransplant = value as YesOrNo; }); }
  void stateSetter33(YesOrNo? value) { setState(() { _brainMembraneTransplant = value as YesOrNo; }); }
  void stateSetter34(YesOrNo? value) { setState(() { _boneMarrowOrStemCellsTransplant = value as YesOrNo; }); }
  void stateSetter35(YesOrNo? value) { setState(() { _visitedOrResidedvCJDCountries = value as YesOrNo; }); }
  void stateSetter36(YesOrNo? value) { setState(() { _bloodTransfusionOrInjectionInTheUK = value as YesOrNo; }); }
  void stateSetter37(YesOrNo? value) { setState(() { _visitedOrResidedInEuropeanCountries = value as YesOrNo; }); }
  void stateSetter38(YesOrNo? value) { setState(() { _hadGaySex = value as YesOrNo; }); }
  void stateSetter39(YesOrNo? value) { setState(() { _hadSexWithPro = value as YesOrNo; }); }
  void stateSetter40(YesOrNo? value) { setState(() { _hadPaidOrReceivedPaymentForSex = value as YesOrNo; }); }
  void stateSetter41(YesOrNo? value) { setState(() { _hadMoreThanOneSexPartner = value as YesOrNo; }); }
  void stateSetter42(YesOrNo? value) { setState(() { _hadNewSexPartnerLast12Months = value as YesOrNo; }); }
  void stateSetter43(YesOrNo? value) { setState(() { _injectedIllegalDrugs = value as YesOrNo; }); }
  void stateSetter44(YesOrNo? value) { setState(() { _sexPartnerIncludedInAnyCategoryAbove = value as YesOrNo; }); }
  void stateSetter45(YesOrNo? value) { setState(() { _testedPositiveForHIV = value as YesOrNo; }); }
  void stateSetter46(YesOrNo? value) { setState(() { _thinkTestedPositiveForHIV = value as YesOrNo; }); }
  void stateSetter47(YesOrNo? value) { setState(() { _onPeriod = value as YesOrNo; }); }
  void stateSetter48(YesOrNo? value) { setState(() { _pregoOrMaybePrego = value as YesOrNo; }); }
  void stateSetter49(YesOrNo? value) { setState(() { _haveBreastFeedingChild = value as YesOrNo; }); }
  void stateSetter50(YesOrNo? value) { setState(() { _givenBirthOrHadMiscarriageLast6Months = value as YesOrNo; }); }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    String saveBDEQ() {
      String result = "";

      result += "${formatYesOrNo(_feelingWellToday)},";
      result += "${formatYesOrNo(_donatingToTestForHIV)},";
      result += "${formatYesOrNo(_donatedBefore)},";
      result += "${formatYesOrNo(_anyProblemsDuringOrAfterDonated)}:";
      result += _problemsDonatingController.text;
      result += ",${formatYesOrNo(_takingAnyMeds)}:";
      result += _takeAnyMedsController.text;
      result += ",${formatYesOrNo(_sufferedFeverColdCough)},";
      result += "${formatYesOrNo(_attackedByHeadacheMigraine)},";
      result += "${formatYesOrNo(_seekedMedAttention)}:";
      result += _seekedMedAttentionController.text;
      result += ",${formatYesOrNo(_jaundice)},";
      result += "${formatYesOrNo(_drycough)},";
      result += "${formatYesOrNo(_HepBOrHepC)},";
      result += "${formatYesOrNo(_diabetes)},";
      result += "${formatYesOrNo(_hiv)},";
      result += "${formatYesOrNo(_hbp)},";
      result += "${formatYesOrNo(_std)},";
      result += "${formatYesOrNo(_heartDiseases)},";
      result += "${formatYesOrNo(_malaria)},";
      result += "${formatYesOrNo(_mentalIllnesses)},";
      result += "${formatYesOrNo(_kidneyDiseases)},";
      result += "${formatYesOrNo(_epilepsy)},";
      result += "${formatYesOrNo(_asthma)},";
      result += "${formatYesOrNo(_others)}:";
      result += _otherDiseasesController.text;
      result += ",${formatYesOrNo(_hepBHepC)}:";
      result += _relationToHepBCController.text;
      result += ",${formatYesOrNo(_undergoneSurgery)},";
      result += "${formatYesOrNo(_receivedBloodTransfusion)},";
      result += "${formatYesOrNo(_gotAccidentalNeedleStickInjury)},";
      result += "${formatYesOrNo(_receivedImmunizationShotOrBeautyInjection)}:";
      result += _typeOfImmunizationShotOrBeautyShotController.text;
      result += ",${formatYesOrNo(_hadDentalTreatment)},";
      result += "${formatYesOrNo(_piercingsTattoosCuppingAcupuncture)},";
      result += "${formatYesOrNo(_hadADrinkLast24Hours)},";
      result += "${formatYesOrNo(_humanGrowthHormoneInjection)},";
      result += "${formatYesOrNo(_corneaTransplant)},";
      result += "${formatYesOrNo(_brainMembraneTransplant)},";
      result += "${formatYesOrNo(_boneMarrowOrStemCellsTransplant)},";
      result += "${formatYesOrNo(_visitedOrResidedvCJDCountries)},";
      result += "${formatYesOrNo(_bloodTransfusionOrInjectionInTheUK)},";
      result += "${formatYesOrNo(_visitedOrResidedInEuropeanCountries)},";
      result += "${formatYesOrNo(_hadGaySex)},";
      result += "${formatYesOrNo(_hadSexWithPro)},";
      result += "${formatYesOrNo(_hadPaidOrReceivedPaymentForSex)},";
      result += "${formatYesOrNo(_hadMoreThanOneSexPartner)},";
      result += "${formatYesOrNo(_hadNewSexPartnerLast12Months)},";
      result += "${formatYesOrNo(_injectedIllegalDrugs)},";
      result += "${formatYesOrNo(_sexPartnerIncludedInAnyCategoryAbove)},";
      result += "${formatYesOrNo(_testedPositiveForHIV)},";
      result += "${formatYesOrNo(_thinkTestedPositiveForHIV)},";
      result += "${formatYesOrNo(_onPeriod)},";
      result += "${formatYesOrNo(_pregoOrMaybePrego)},";
      result += "${formatYesOrNo(_haveBreastFeedingChild)},";
      result += "${formatYesOrNo(_givenBirthOrHadMiscarriageLast6Months)},";

      // print("Result: " + result);

      return result;
    }

    void saveAppointment() {
      final appData = <String, dynamic>{};
      appData["date"] = Timestamp.fromDate(arguments["chosenDateTime"]);
      appData["donor"] = arguments["email"];
      appData["hospital"] = arguments["chosenHospital"];
      appData["timeslot"] = arguments["chosenTimeslot"];
      appData["created"] = Timestamp.now();
      appData["BDEQ"] = saveBDEQ();
      
      final docRef = db.collection("appointments");
      docRef.add(appData).then((documentSnapshot) => print("Added Data with ID: ${documentSnapshot.id}"));
    }
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Blood Donor Eligibility Questionnaire",
            style: TextStyle(
              fontSize: 18.0,
              // color: Colors.white
            )
          ),
          // backgroundColor: Color(0xFFBC3B3B),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
          child: ListView(
            children: [
              const ListTile(
                title: Text(
                  "\"Any blood donor who is found to have made a false statement related to their high-risk lifestyle behavior will be prosecuted in Court according to the law in force.\"",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0
                  ),
                )
              ),
              const ListTile(
                title: Text("Answer all the questions."),
                leading: Icon(Icons.info),
              ),
              const ListTile(
                title: Text("1. Are you feeling well today?"),
              ),
              YesOrNoWidget(
                question: _feelingWellToday,
                parentSetState: stateSetter1,
              ),
              const ListTile( title: Text("2. Are you donating to have your blood tested for HIV, Hepatitis and/or Syphilis?") ),
              YesOrNoWidget(
                question: _donatingToTestForHIV,
                parentSetState: stateSetter2,
              ),
              const ListTile( title: Text("3. Have you donated blood before?") ),
              YesOrNoWidget(
                question: _donatedBefore,
                parentSetState: stateSetter3,
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("If so, have you ever had any problems during or after donating?")
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(
                    question: _anyProblemsDuringOrAfterDonated,
                    parentSetState: stateSetter4,
                  ),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("If so, please state:"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: MyTextfield(
                    controller: _problemsDonatingController,
                    hintText: "",
                    obscureText: false,
                  ),
                ),
              ),
              const ListTile( title: Text("4. In the past week, have you:") ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("a) Taking any medications?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(
                    question: _takingAnyMeds,
                    parentSetState: stateSetter5,
                  ),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("If yes, please state:"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: MyTextfield(
                    controller: _takeAnyMedsController,
                    hintText: "",
                    obscureText: false,
                  ),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("b) Suffering from fever, cold and/or cough?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(
                    question: _sufferedFeverColdCough,
                    parentSetState: stateSetter6,
                  ),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("c) Attacked by a headache or migraine?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(
                    question: _attackedByHeadacheMigraine,
                    parentSetState: stateSetter7,
                  ),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("d) Seeking medical attention for any health problem?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _seekedMedAttention, parentSetState: stateSetter8),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("If yes, please specify:"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: MyTextfield(
                    controller: _seekedMedAttentionController,
                    hintText: "",
                    obscureText: false,
                  ),
                ),
              ),
              const ListTile(
                title: Text("5. Are you suffering / have suffered / are being treated / have been treated for any of the following health problems?")
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Yellow fever / Jaundice"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _jaundice, parentSetState: stateSetter9),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Dry cough"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _drycough, parentSetState: stateSetter10),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Hepatitis B or Hepatitis C"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _HepBOrHepC, parentSetState: stateSetter11),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Diabetes"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _diabetes, parentSetState: stateSetter12),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  HIV"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _hiv, parentSetState: stateSetter13),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  High blood pressure"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _hbp, parentSetState: stateSetter14),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Sexually Transmitted Diseases / Syphilis"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _std, parentSetState: stateSetter15),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Heart disease"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _heartDiseases, parentSetState: stateSetter16),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Malaria"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _malaria, parentSetState: stateSetter17),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Mental illness"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _mentalIllnesses, parentSetState: stateSetter18),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Kidney disease"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _kidneyDiseases, parentSetState: stateSetter19),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Epilepsy / Seizures"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _epilepsy, parentSetState: stateSetter20),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Asthma / Fatigue"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _asthma, parentSetState: stateSetter21),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("●  Others"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _others, parentSetState: stateSetter22),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("If yes, please specify:"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: MyTextfield(
                    controller: _otherDiseasesController,
                    hintText: "",
                    obscureText: false,
                  ),
                ),
              ),
              const ListTile(
                title: Text("6. Has anyone in your family ever suffered from or is being treated for Hepatitis B or Hepatitis C?")
              ),
              YesOrNoWidget(question: _hepBHepC, parentSetState: stateSetter23),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("If yes, please state your relationship with them:"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: MyTextfield(
                    controller: _relationToHepBCController,
                    hintText: "",
                    obscureText: false,
                  ),
                ),
              ),
              const ListTile( title: Text("7. In the past 6 months, have you:") ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("a) Undergoing any surgical treatment?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _undergoneSurgery, parentSetState: stateSetter24),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("b) Receiving a blood transfusion?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _receivedBloodTransfusion, parentSetState: stateSetter25),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("c) Got an accidental needle stick injury?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _gotAccidentalNeedleStickInjury, parentSetState: stateSetter26),
                ),
              ),
              const ListTile( title: Text("8. Have you ever received an immunization shot or any form of injection for beauty (eg: botox, collagen) in the last 4 weeks?") ),
              YesOrNoWidget(question: _receivedImmunizationShotOrBeautyInjection, parentSetState: stateSetter27),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("If yes, please state the type and/or purpose:"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: MyTextfield(
                    controller: _typeOfImmunizationShotOrBeautyShotController,
                    hintText: "",
                    obscureText: false,
                  ),
                ),
              ),
              const ListTile( title: Text("9. Have you had dental treatment in the last 24 hours?") ),
              YesOrNoWidget(question: _hadDentalTreatment, parentSetState: stateSetter28),
              const ListTile( title: Text("10. Have you ever pierced any part of the body (body piercing), tattooed (tattooing), cupping or undergoing acupuncture in the last 6 months?") ),
              YesOrNoWidget(question: _piercingsTattoosCuppingAcupuncture, parentSetState: stateSetter29),
              const ListTile( title: Text("11. Have you had a drink in the last 24 hours? alcoholic to intoxicating?  Have you ever received treatment?") ),
              YesOrNoWidget(question: _hadADrinkLast24Hours, parentSetState: stateSetter30),
              const ListTile( title: Text("12. Have you ever received treatment?") ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("a) Human growth hormone injection?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _humanGrowthHormoneInjection, parentSetState: stateSetter31),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("b) Transplantation of the cornea?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _corneaTransplant, parentSetState: stateSetter32),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("c) Transfer (transplantation) of the brain membrane (dura mater)?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _brainMembraneTransplant, parentSetState: stateSetter33),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("d) Transplantation (transplantation) of bone marrow or stem cells (stem cells)?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _boneMarrowOrStemCellsTransplant, parentSetState: stateSetter34),
                ),
              ),
              const ListTile( title: Text("13. Risk of infection with variant Creutzfeldt-Jakob Disease (vCJD)") ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("a) Have you visited or resided in the United Kingdom (England, Northern Ireland, Wales, Scotland, Isle of Man, Channel Island) or the Republic of Ireland for a cumulative period of 6 months or more between 1st January 1980 and 31st December 1996?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _visitedOrResidedvCJDCountries, parentSetState: stateSetter35),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("b) Have you received a transfusion or injection of blood or blood products while in the United Kingdom between 1st January 1980 and now?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _bloodTransfusionOrInjectionInTheUK, parentSetState: stateSetter36),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("c) Have you visited or resided in the following European countries* for a cumulative period of 5 years or more between 1st January 1980 and the present? (*Austria, Netherlands, Belgium, Denmark, Finland, Greece, Germany, Italy, Liechtenstein, Luxembourg, Norway, France, Portugal, Spain, Sweden and Switzerland)"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _visitedOrResidedInEuropeanCountries, parentSetState: stateSetter37),
                ),
              ),
              const ListTile( title: Text("14. For patient safety, the following questions MUST be answered HONESTLY, even if they only involve you once. You are required to answer the following questions in front of the doctor or KKM officer who interviews you.") ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("a) If you are a man, have you ever had sex with another man?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _hadGaySex, parentSetState: stateSetter38),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("b) Have you ever had sex with a commercial sex worker (prostitute)?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _hadSexWithPro, parentSetState: stateSetter39),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("c) Have you ever paid or received payment for sex?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _hadPaidOrReceivedPaymentForSex, parentSetState: stateSetter40),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("d) Have you ever had more than one sex partner?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _hadMoreThanOneSexPartner, parentSetState: stateSetter41),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("e) Have you had a new sex partner in the past 12 months?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _hadNewSexPartnerLast12Months, parentSetState: stateSetter42),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("f) Have you ever injected yourself with illegal drugs, including bodybuilding drugs?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _injectedIllegalDrugs, parentSetState: stateSetter43),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("g) Does your sex partner belong to any of the above categories?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _sexPartnerIncludedInAnyCategoryAbove, parentSetState: stateSetter44),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("h) Have you or your sex partner ever tested positive for HIV?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _testedPositiveForHIV, parentSetState: stateSetter45),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("i) Do you think you or your sex partner might be infected with HIV?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _thinkTestedPositiveForHIV, parentSetState: stateSetter46),
                ),
              ),
              const ListTile( title: Text("15. To be answered by female donors only") ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("a) Are you on your period now?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _onPeriod, parentSetState: stateSetter47),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("b) Are you pregnant or may be pregnant?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _pregoOrMaybePrego, parentSetState: stateSetter48),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("c) Do you have a child who is still breastfeeding?"),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: YesOrNoWidget(question: _haveBreastFeedingChild, parentSetState: stateSetter49),
                ),
              ),
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("d) Have you given birth or had a miscarriage in the last 6 months?"),
                ),
              ),
              ListTile( title: YesOrNoWidget(question: _givenBirthOrHadMiscarriageLast6Months, parentSetState: stateSetter50), leading: const SizedBox(width: 4.0) ),
              const SizedBox(height: 50.0),
              MyButton(
                text: "Save",
                onTap: () => {
                  saveAppointment(),
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "user_confirm_appointment",
                    (Route<dynamic> route) => false,
                    arguments: arguments,
                  )
                },
                verificationPassed: true,
              ),
            ],
          ),
        ),
      )
    );
  }
}