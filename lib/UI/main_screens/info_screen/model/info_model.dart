import 'package:flutter/cupertino.dart';

class Info {
  String title;
  String description;
  String assetImage;

  Info(
      {@required this.assetImage,
      @required this.description,
      @required this.title});

  static List<Info> information = [
    Info(
        assetImage: "assets/images/covid.jpg",
        description:
            "COVID-19 is an infectious disease caused by the last detected strain of coronavirus. There was no knowledge of this new virus and its disease before its outbreak began in the Chinese city of Wuhan in December 2019. COVID-19 has now turned into a pandemic affecting many countries in the world.",
        title: "Whats is COVID-19 ?"),
    Info(
        title: "Covid Mask",
        description:
            '''There is currently no evidence to support or deny the usefulness of wearing masks (medical or other) for healthy people in the community in general. However, the organization is studying the rapidly developing scientific knowledge about masks and constantly updating its guidelines in this regard.
Medical masks are recommended primarily in healthcare facilities, but may be considered for use in other circumstances as well (see below). The use of medical masks should be combined with other key infection prevention and control measures, such as hand hygiene and physical distancing.''',
        assetImage: "assets/images/baby.jpg"),
    Info(
        title: "How to protect myself ?",
        description:
            '''Keep your hands clean by rubbing them with an alcohol-based hand sanitizer or by washing them with soap and water.
 Why? Cleaning your hands with soap and water or rubbing them with an alcohol-based hand sanitizer kills viruses that may be on your hands.
\nMaintain at least 1 meter (3 feet) distance between yourself and others.
  Why? When a person coughs or sneezes, they secrete small liquid droplets from their nose or mouth that may contain the virus. If you are too close to him, you can breathe in these droplets, including the virus that causes COVID-19 if that person has it.
\nAvoid crowded places
 Why? When people crowd into crowded places, people who have COVID-19 are more likely to come into contact with someone who has COVID-19 and it is difficult to maintain a distance of 1 meter (3 feet) between you and others.
\nAvoid touching your eyes, nose and mouth.''',
        assetImage: "assets/images/vaccine.jpg"),
    Info(
        assetImage: "assets/images/covidMap.jpg",
        description:
            '''If your symptoms are mild, such as a slight cough or a slight fever, there is generally no need to seek medical attention. Stay home, isolate yourself, and monitor your symptoms. Follow the national guidelines on self-isolation. But if you live in an area where malaria or dengue is common, it's important not to ignore the symptoms of a fever. Seek medical help. When you go to the health care facility, wear a mask if possible, keep at least 1 meter between yourself and others and avoid touching surfaces around your hands. If the patient is a child, help him adhere to these tips.
Seek medical attention immediately if you have difficulty breathing or chest pain/pressure. If possible, contact your doctor in advance so that he or she can direct you to the appropriate health facility''',
        title: "How to recover from COVID-19"),
    Info(
        assetImage: "assets/images/shakeHandes.jpg",
        title: "How does COVID-19 spread?",
        description:
            '''People can catch COVID-19 from other people who have the virus. The disease is mainly spread from person to person through the small droplets that a person with COVID-19 secretes from his nose or mouth when he coughs, sneezes or speaks. These droplets are relatively heavy in weight, as they do not move to a far place, but rather quickly fall to the ground. People can catch COVID-19 if they breathe in these droplets from a person who has the virus. It is therefore important to maintain a distance of at least 1 meter (3 feet) from others. These droplets may land on objects and surfaces around the person, such as tables, doorknobs, and stair rails. People can then become infected by touching these objects or surfaces and then touching their eyes, nose or mouth. Therefore, it is important to wash hands regularly with soap and water or clean them with an alcohol-based hand rub.
WHO is evaluating ongoing research into the ways COVID-19 is spread and will continue to publish its most recent findings'''),
    Info(
        assetImage: "assets/images/stayHome.jpg",
        description:
            '''Self-isolation is an important measure for people showing symptoms of COVID-19 to avoid infecting others in the community, including their family members.
Self-isolation is when a person with a fever, cough or other symptoms of COVID-19 stays home and refrains from going to work, school or public places. This isolation can occur voluntarily or based on the recommendation of a health care provider. But if you live in an area where malaria or dengue is common, it's important not to ignore the symptoms of a fever. Seek medical help. When you go to the health care facility, wear a mask if possible, keep at least one meter between yourself and others and avoid touching surrounding surfaces with your hands.''',
        title: "What does self-isolation mean?"),
    Info(
        assetImage: "assets/images/cleanHands.jpg",
        description:
            "To prevent COVID-19, avoid any physical contact when greeting others. Safe greetings include waving, nodding, and bowing.",
        title: "How to safely greet my friends"),
    Info(
        assetImage: "assets/images/covid19.jpg",
        description:
            '''Both. Antibiotics do not kill viruses, only bacterial infections. Since COVID-19 is caused by a virus, antibiotics are not effective in combating it. Antibiotics should not be used as a way to prevent or treat COVID-19. But hospital doctors may prescribe antibiotics for patients with severe COVID-19 complications to treat or prevent a secondary bacterial infection. The doctor's instructions should be strictly adhered to when using antibiotics to treat bacterial infections''',
        title: "Are antibiotics effective in preventing COVID-19?")
  ];
}
