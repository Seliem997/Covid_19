import 'package:covid19/UI/main_screens/covid_check/symptom.dart';
import 'package:flutter/material.dart';

class CovidCheckProvider extends ChangeNotifier {
  double _progress = 0.0;

  Symptom fever = Symptom(name: "Fever");
  Symptom shortnessOfBreathing = Symptom(name: "Shortness of breathing");
  Symptom dryCough = Symptom(name: "Dry cough");
  Symptom fatigue = Symptom(name: "Fatigue");
  Symptom exhausting = Symptom(name: "Exhausting");
  Symptom painInchest = Symptom(name: "Pain In Chest");
  Symptom painsAndSoreness = Symptom(name: " Pains And Soreness");
  Symptom soreThroat = Symptom(name: "Sore Throat");
  Symptom diarrhea = Symptom(name: "Diarrhea");
  Symptom headache = Symptom(name: "Headache");
  Symptom sneezing = Symptom(name: "Sneezing");
  Symptom chestSeizures = Symptom(name: "Chest Seizures");

  get progress => _progress;

  double checkSymptom(List<Symptom> symptoms) {
    _progress = 0.0;
    symptoms.forEach((symptom) {
      if (symptom.isSelected == true)
        _progress = _progress + 100 / 12 / 100 - .0001;
    });
    notifyListeners();
    return _progress;
  }
}
