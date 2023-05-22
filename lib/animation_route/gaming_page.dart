import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:html' as html;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  TextEditingController inputController = TextEditingController();
  String _userText = "Type Something";
  String replyTest = "See The Result";
  bool showTable = false;
  bool container = false;
  bool circle = false;
  int rNumber = 0;
  List<Messages> listMesseges = [];

  String address = '';
  double latitude = 0.0;
  double longitude = 0.0;
  String systemName = '';
  String browserName = '';

  @override
  void initState() {
    super.initState();
    getUserLocation();
    getSystemName();
    getBrowserName();
    getBatteryLevel();
    getWifiNetworkType();
  }

  Future<void> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    final addressloc = await getAddress(latitude, longitude);
    setState(() {
      address = addressloc;
    });
  }

  Future<String> getAddress(double latitude, double longitude) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      final address = decodedData['display_name'];
      return address;
    }

    return 'Address not found';
  }

  void getSystemName() {
    setState(() {
      systemName = html.window.navigator.platform!;
    });
  }

  void getBrowserName() {
    setState(() {
      browserName = html.window.navigator.userAgent;
    });
  }

  Map<String, String> getReplayList = {
    "hello": "Hi",
    "hi": "Hello!",
    "hey": "Hey there!",
    "yes": "Sure",
    "no": "Nope",
    "okay": "Alright",
    "thanks": "Thank you",
    "bye": "Goodbye",
    "sorry": "Apologies",
    "cool": "Awesome",
    "nice": "Great",
    "wow": "Amazing",
    "oops": "Mistake",
    "haha": "Funny",
    "love": "Adore",
    "awesome": "Fantastic",
    "oops": "Oopsie",
    "amazing": "Incredible",
    "good": "Excellent",
    "bad": "Terrible",
    "great": "Superb",
    "wow": "Impressive",
    "okay": "Fine",
    "yay": "Hooray",
    "uh-oh": "Trouble",
    "hooray": "Cheers",
    "nice": "Splendid",
    "fantastic": "Magnificent",
    "bravo": "Well done",
    "wonderful": "Marvelous",
    "yes": "Affirmative",
    "no": "Negative",
    "excellent": "Outstanding",
    "perfect": "Flawless",
    "wow": "Spectacular",
    "amazing": "Phenomenal",
    "impressive": "Stunning",
    "goodbye": "Farewell",
    "thank you": "Grateful",
    "sorry": "Apologies",
    "love": "Adoration",
    "cool": "Rad",
    "super": "Superb",
    "delicious": "Yummy",
    "quick": "Swift",
    "smart": "Intelligent",
    "fun": "Enjoyable",
    "exciting": "Thrilling",
    "interesting": "Fascinating",
    "relaxing": "Calming",
    "beautiful": "Gorgeous",
    "powerful": "Mighty",
    "amazing": "Astounding",
    "happy": "Joyful",
    "sad": "Gloomy",
    "strong": "Robust",
    "bright": "Radiant",
    "funny": "Hilarious",
    "energetic": "Vibrant",
    "brilliant": "Genius",
    "clever": "Smart",
    "sweet": "Charming",
    "kind": "Compassionate",
    "gentle": "Tender",
    "excited": "Thrilled",
    "awesome": "Spectacular",
    "magical": "Enchanting",
    "adventurous": "Daring",
    "brave": "Courageous",
    "witty": "Clever",
    "silly": "Goofy",
    "crazy": "Insane",
    "fierce": "Intense",
    "wonderful": "Marvelous",
    "vibrant": "Lively",
    "peaceful": "Serene",
    "playful": "Cheerful",
    "charming": "Captivating",
    "talented": "Gifted",
    "famous": "Renowned",
    "relieved": "Grateful",
    "proud": "Triumphant",
    "free": "Liberated",
    "blessed": "Fortunate",
    "curious": "Inquisitive",
    "bold": "Fear less",
    "satisfied": "Content",
    "humbled": "Modest",
    "optimistic": "Hopeful",
    "grateful": "Thankful",
    "inspired": "Motivated",
    "determined": "Resolute",
    "energized": "Invigorated",
    "refreshed": "Revitalized",
    "peaceful": "Tranquil",
    "fierce": "Fearless",
    "curious": "Inquisitive",
    "vibrant": "Dynamic",
    "fascinated": "Enthralled",
    "accomplished": "Achieved",
    "comfortable": "Cozy",
    "serene": "Placid",
    "courageous": "Fearless",
    "clever": "Smart",
    "witty": "Sharp",
    "relaxed": "Unwound",
    "motivated": "Driven",
    "amused": "Entertained",
    "satisfied": "Fulfilled",
    "joyful": "Blissful",
    "adored": "Cherished",
    "radiant": "Glowing",
    "robust": "Vigorous",
    "thriving": "Prosperous",
    "exhilarated": "Euphoric",
    "respected": "Valued",
    "accomplished": "Successful",
    "appreciated": "Recognized",
    "supported": "Encouraged",
    "loved": "Adored",
    "admired": "Esteemed",
    "cheerful": "Jovial",
    "unique": "Distinct",
    "extraordinary": "Exceptional",
    "fearless": "Courageous",
    "dynamic": "Energetic",
    "charismatic": "Charming",
    "innovative": "Creative",
    "passionate": "Enthusiastic",
    "vital": "Essential",
    "vibrant": "Radiant",
    "successful": "Triumphant",
    "brilliant": "Brilliant",
    "dazzling": "Dazzling",
    "mesmerizing": "Spellbinding",
    "legendary": "Iconic",
    "timeless": "Classic",
    "priceless": "Invaluable",
    "unforgettable": "Memorable",
    "marvelous": "Wonderful",
    "exquisite": "Beautiful",
    "majestic": "Regal",
    "breathtaking": "Stunning",
    "grand": "Majestic",
    "stunning": "Gorgeous",
    "captivating": "Enchanting",
    "spellbinding": "Mesmerizing",
    "enchanting": "Captivating",
    "alluring": "Enticing",
    "bewitching": "Entrancing",
    "radiant": "Beaming",
    "ethereal": "Heavenly",
    "divine": "Sacred",
    "serene": "Tranquil",
    "peaceful": "Calm",
    "harmonious": "Melodious",
    "blissful": "Joyous",
    "tranquil": "Soothing",
    "serene": "Placid",
    "content": "Satisfied",
    "grateful": "Thankful",
    "blessed": "Fortunate",
    "fulfilled": "Satiated",
    "radiant": "Glowing",
    "exuberant": "Energized",
    "euphoric": "Elated",
    "vivacious": "Lively",
    "lively": "Animated",
    "dynamic": "Energetic",
    "vibrant": "Thriving",
    "joyful": "Blissful",
    "ecstatic": "Rapturous",
    "overjoyed": "Delighted",
    "thrilled": "Excited",
    "enthusiastic": "Passionate",
    "inspired": "Motivated",
    "determined": "Resolute",
    "confident": "Assured",
    "positive": "Optimistic",
    "uplifted": "Encouraged",
    "empowered": "Assertive",
    "strong": "Powerful",
    "bold": "Courageous",
    "fearless": "Fearless",
    "tenacious": "Persistent",
    "ambitious": "Driven",
    "focused": "Concentrated",
    "dedicated": "Committed",
    "persevering": "Resilient",
    "resourceful": "Ingenious",
    "innovative": "Creative",
    "clever": "Smart",
    "brilliant": "Genius",
    "sharp": "Keen",
    "wise": "Sage",
    "intuitive": "Insightful",
    "knowledgeable": "Informed",
    "insightful": "Perceptive",
    "astute": "Discerning",
    "observant": "Attentive",
    "calm": "Tranquil",
    "relaxed": "Serene",
    "peaceful": "Harmonious",
    "centered": "Balanced",
    "grounded": "Steadfast",
    "collected": "Composed",
    "soothed": "Soothed",
    "refreshed": "Revitalized",
    "rejuvenated": "Renewed",
    "revived": "Restored",
    "balanced": "Stable",
    "fulfilled": "Content",
    "grateful": "Thankful",
    "satisfied": "Pleased",
    "appreciated": "Valued",
    "loved": "Cherished",
    "admired": "Respected",
    "supported": "Encouraged",
    "accepted": "Embraced",
    "cherished": "Treasured",
    "respected": "Honored",
    "valued": "Esteemed",
    "encouraged": "Motivated",
    "motivated": "Inspired",
    "inspired": "Creative",
    "creative": "Innovative",
    "innovative": "Resourceful",
    "resourceful": "Adaptable",
    "adaptable": "Flexible",
    "flexible": "Versatile",
    "versatile": "Diverse",
    "passionate": "Enthusiastic",
    "enthusiastic": "Eager",
    "eager": "Keen",
    "keen": "Avid",
    "avid": "Zealous",
    "zealous": "Fervent",
    "fervent": "Intense",
    "intense": "Fiery",
    "fiery": "Passionate",
    "passionate": "Burning",
    "loving": "Affectionate",
    "affectionate": "Tender",
    "tender": "Gentle",
    "gentle": "Caring",
    "caring": "Nurturing",
    "nurturing": "Supportive",
    "supportive": "Encouraging",
    "encouraging": "Uplifting",
    "uplifting": "Inspiring",
    "inspiring": "Motivating",
    "motivating": "Empowering",
    "empowering": "Transformative",
    "transformative": "Life-changing",
    "life-changing": "Impactful",
    "impactful": "Influential",
    "influential": "Empowered",
    "empowered": "Resilient",
    "resilient": "Strong",
    "strong": "Indomitable",
    "indomitable": "Unyielding",
    "unyielding": "Invincible",
    "invincible": "Unstoppable",
    "unstoppable": "Unbreakable",
    "unbreakable": "Unshakable",
    "unshakable": "Tenacious",
    "tenacious": "Relentless",
    "relentless": "Persistent",
    "persistent": "Determined",
    "determined": "Focused",
    "focused": "Ambitious",
    "ambitious": "Aspiring",
    "aspiring": "Motivated",
    "motivated": "Driven",
    "driven": "Achieving",
    "achieving": "Successful",
    "successful": "Triumphant",
    "triumphant": "Victorious",
    "victorious": "Accomplished",
    "accomplished": "Fulfilled",
    "fulfilled": "Satisfied",
    "satisfied": "Content",
    "content": "Happy",
    "happy": "Joyful",
    "joyful": "Euphoric",
    "euphoric": "Ecstatic",
    "ecstatic": "Blissful",
    "blissful": "Radiant",
    "radiant": "Glowing",
    "glowing": "Thriving",
    "thriving": "Vibrant",
    "vibrant": "Alive",
    "alive": "Dynamic",
    "dynamic": "Enlivened",
    "enlivened": "Revitalized",
    "revitalized": "Refreshed",
    "refreshed": "Renewed",
    "renewed": "Rejuvenated",
    "rejuvenated": "Restored",
    "restored": "Empowered",
    "empowered": "Confident",
    "confident": "Secure",
    "secure": "Steadfast",
    "steadfast": "Grounded",
    "grounded": "Balanced",
    "balanced": "Harmonious",
    "harmonious": "Peaceful",
    "peaceful": "Tranquil",
    "tranquil": "Serene",
    "serene": "Calm",
    "calm": "Centered",
    "centered": "Aligned",
    "aligned": "Focused",
    "focused": "Clear",
    "clear": "Free",
    "free": "Libe rated",
    "liberated": "Free-spirited",
    "free-spirited": "Unrestricted",
    "unrestricted": "Uninhibited",
    "uninhibited": "Unfettered",
    "unfettered": "Unchained",
    "unchained": "Unbound",
    "unbound": "Limitless",
    "limitless": "Boundless",
    "boundless": "Infinite",
    "infinite": "Eternal",
    "eternal": "Timeless",
    "timeless": "Ageless",
    "ageless": "Everlasting",
    "everlasting": "Immortal",
    "immortal": "Endless",
    "endless": "Perpetual",
    "perpetual": "Continuous",
    "continuous": "Uninterrupted",
    "uninterrupted": "Seamless",
    "seamless": "Flawless",
    "flawless": "Perfect",
    "perfect": "Exquisite",
    "exquisite": "Breathtaking",
    "breathtaking": "Captivating",
    "captivating": "Enchanting",
    "enchanting": "Mesmerizing",
    "mesmerizing": "Spellbinding",
    "spellbinding": "Alluring",
    "alluring": "Irresistible",
    "irresistible": "Seductive",
    "seductive": "Enticing",
    "enticing": "Enthralling",
    "enthralling": "Fascinating",
    "fascinating": "Compelling",
    "compelling": "Intriguing",
    "intriguing": "Mysterious",
    "mysterious": "Enigmatic",
    "enigmatic": "Provocative",
    "provocative": "Stimulating",
    "stimulating": "Thought-provoking",
    "thought-provoking": "Inspiring",
    "inspiring": "Empowering",
    "empowering": "Uplifting",
    "uplifting": "Motivating",
    "motivating": "Encouraging",
    "encouraging": "Supportive",
    "supportive": "Nurturing",
    "nurturing": "Caring",
    "caring": "Compassionate",
    "compassionate": "Kind",
    "kind": "Benevolent",
    "benevolent": "Generous",
    "generous": "Gracious",
    "gracious": "Hospitable",
    "hospitable": "Warm",
    "warm": "Inviting",
    "inviting": "Welcoming",
    "welcoming": "Friendly",
    "friendly": "Amicable",
    "amicable": "Harmonious",
    "harmonious": "Cooperative",
    "cooperative": "Collaborative",
    "collaborative": "Unified",
    "unified": "Synergistic",
    "synergistic": "Connected",
    "connected": "Bonded",
    "bonded": "United",
    "united": "Solidarity",
    "solidarity": "Support",
    "support": "Assistance",
    "assistance": "Help",
    "help": "Guidance",
    "guidance": "Direction",
    "direction": "Clarity",
    "clarity": "Focus",
    "focus": "Concentration",
    "concentration": "Determination",
    "determination": "Perseverance",
    "perseverance": "Endurance",
    "endurance": "Resilience",
    "resilience": "Strength",
    "strength": "Fortitude",
    "fortitude": "Courage",
    "courage": "Bravery",
    "bravery": "Fearlessness",
    "fearlessness": "Boldness",
    "boldness": "Adventurous",
    "adventurous": "Daring",
    "daring": "Risk-taking",
    "risk-taking": "Thrilling",
    "thrilling": "Exhilarating",
    "exhilarating": "Electrifying",
    "electrifying": "Stimulating",
    "stimulating": "Invigorating",
    "invigorating": "Energizing",
    "energizing": "Revitalizing",
    "revitalizing": "Refreshing",
    "refreshing": "Renewing",
    "renewing": "Rejuvenating",
    "rejuvenating": "Restorative",
    "restorative": "Transformative",
    "transformative": "Life-changing",
    "life-changing": "Impactful",
    "impactful": "Influential",
    "influential": "Empowered",
    "empowered": "Confident",
    "confident": "Secure",
    "secure": "Steadfast",
    "steadfast": "Grounded",
    "grounded": "Balanced",
    "balanced": "Harmonious",
    "harmonious": "Peaceful",
    "peaceful": "Tranquil",
    "tranquil": "Serene",
    "serene": "Calm",
    "calm": "Centered",
    "centered": "Aligned",
    "aligned": "Focused",
    "focused": "Clear",
    "clear": "Free",
    "free": "Liberated",
    "liberated": "Empowered",
    "how are you": "I'm good, thanks!",
    "what's up": "Not much, just chatting.",
    "good morning": "Good morning!",
    "good afternoon": "Good afternoon!",
    "good evening": "Good evening!",
    "good night": "Good night!",
    "thank you": "You're welcome!",
    "thanks": "You're welcome!",
    "bye": "Goodbye!",
    "see you later": "See you later!",
    "take care": "You too!",
    "nice to meet you": "Nice to meet you too!",
    "how's your day": "It's going well!",
    "how's the weather": "It's sunny and pleasant!",
    "tell me a joke":
        "Sure! Why don't scientists trust atoms? Because they make up everything!",
    "what's your favorite food":
        "I'm a virtual assistant, so I don't eat. But I can help you find recipes!",
    "can you recommend a movie":
        "Sure! How about watching 'Inception'? It's mind-bending!",
    "tell me something interesting":
        "Did you know that the average person walks the equivalent of five times around the world in their lifetime?",
    "do you have any hobbies":
        "I enjoy helping people, answering questions, and providing information.",
    "where are you from":
        "I'm a virtual assistant, so I don't have a physical location. I'm here to assist you!",
    "what's your favorite color":
        "I don't have a favorite color, but I like all the colors!",
    "are you a robot":
        "I'm an AI-powered virtual assistant. While I'm not a robot, I'm here to help you!",
    "do you believe in ghosts":
        "As a virtual assistant, I don't have personal beliefs.",
    "what's the meaning of life":
        "The meaning of life varies for each individual. It's about finding purpose and happiness.",
    "do you play any sports":
        "I'm a virtual assistant, so I don't play sports. However, I can provide information about various sports!",
    "what's the capital of France": "The capital of France is Paris.",
    "how tall is Mount Everest":
        "Mount Everest is approximately 8,848 meters (29,029 feet) tall.",
    "what's the time": "The current time is [insert current time here].",
    "how old are you": "I'm a virtual assistant, so I don't have an age!",
    "what's your favorite movie genre":
        "I don't have a favorite movie genre, but I enjoy a variety of genres like drama, comedy, and action.",
    "tell me a fun fact":
        "Sure! Did you know that honey never spoils? Archaeologists have found pots of honey in ancient Egyptian tombs!",
    "what's your favorite animal":
        "I don't have a favorite animal, but I find all animals fascinating and unique.",
    "what's your favorite music genre":
        "I don't have a favorite music genre, but I enjoy listening to a wide range of music, from pop to classical.",
    "tell me a famous quote":
        "Sure! Here's one: 'The only way to do great work is to love what you do.' - Steve Jobs",
    "what's the largest country by land area":
        "The largest country by land area is Russia, spanning across Eurasia and covering over 17 million square kilometers.",
  };
  final Battery _battery = Battery();
  final Connectivity _connectivity = Connectivity();

  String _chargingStatus = 'Unknown';
  String _wifiNetworkType = 'Unknown';

  Future<void> getBatteryLevel() async {
    final battery = Battery();
    final batteryLevel = await battery.batteryLevel;
    setState(() {
      _chargingStatus = '$batteryLevel';
    });
  }

  Future<void> getWifiNetworkType() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi) {
      const wifiNetworkType = 'Connected';
      setState(() {
        _wifiNetworkType = wifiNetworkType;
      });
    } else {
      const wifiNetworkType = 'Not connected';
      setState(() {
        _wifiNetworkType = wifiNetworkType;
      });
    }
  }

  _getReply() async {
    final String userGivenText = inputController.text.trim();

    if (userGivenText.isNotEmpty) {
      _userText = userGivenText;
      String userText = userGivenText.toLowerCase();
      inputController.clear();
      addItemToList(Messages(msg: _userText, left: false, shape: 'null'));

      String? rText;
      if (userGivenText.isNumeric) {
        rNumber = int.parse(userGivenText);
        rText = (2 * rNumber).toString();
        showTable = true;
        container = false;
        circle = false;
      } else {
        showTable = false;
        List<String> name = userGivenText.split(' ');
        if (name[0] == 'create') {
          if (name.contains('container')) {
            container = true;
            circle = false;
            rText = 'Container';
          } else if (name.contains('circle')) {
            container = false;
            circle = true;
            rText = 'Circle';
          } else {
            container = false;
            circle = false;
            rText = "I didn't get";
          }
        } else {
          container = false;
          circle = false;
        }

        List<String> checkKeys = getReplayList.keys.toList();

        await Future.forEach(checkKeys, (key) async {
          if (key.toLowerCase() == userText) {
            rText = getReplayList[key].toString();
          }
        });
      }

      String shape = container ? 'container' : (circle ? 'circle' : 'null');
      addItemToList(
          Messages(msg: rText ?? "I didn't get", left: true, shape: shape));
      setState(() {
        replyTest = rText ?? "I didn't get";
      });
    }
  }

  ScrollController _scrollController = ScrollController();

  void addItemToList(Messages message) {
    setState(() {
      listMesseges.add(message);
    });

    // Delay the scroll animation slightly
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 35.0,
                  ),
                ),
                const SizedBox(
                  width: 18.0,
                ),
                SelectableText(
                    'Welcome to Time Pass Game${(address.isNotEmpty) ? '\nAddress: $address' : ''}, ${(systemName.isNotEmpty) ? '\nSystem name: $systemName' : ''}, ${(browserName.isNotEmpty) ? '\nBrowser name: $browserName' : ''},'),
                const SizedBox(
                  width: 18.0,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.battery_full,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 5),
                    Text('$_chargingStatus%'),
                  ],
                ),
                const SizedBox(
                  width: 18.0,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.wifi,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 5),
                    Text(_wifiNetworkType),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    itemCount: listMesseges.length,
                    itemBuilder: (context, index) {
                      final message = listMesseges[index];
                      return Column(
                        crossAxisAlignment: message.left
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: message.left
                                  ? Colors.grey[300]
                                  : Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return message.left
                                    ? TypewriterTextAnimation(
                                        text: message.msg,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        constraints: constraints,
                                      )
                                    : Text(
                                        message.msg,
                                        style: const TextStyle(fontSize: 16),
                                        maxLines: null,
                                        overflow: TextOverflow.clip,
                                      );
                              },
                            ),
                          ),
                          if (message.shape != 'null')
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: message.shape == 'circle'
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                borderRadius: message.shape == 'container'
                                    ? BorderRadius.circular(12)
                                    : null,
                              ),
                              height: 150,
                              width: 150,
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: inputController,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _getReply,
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _getReply,
                        icon: const Icon(Icons.send_sharp),
                        color:
                            Colors.blue, // Set your desired send button color
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showTable)
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int a = 1; a < 11; a++)
                    Text(
                      '$_userText x $a = ${(a * rNumber).toString()}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
}

class Messages {
  final String msg;
  final bool left;
  final String shape;

  Messages({required this.msg, required this.left, required this.shape});
}

class TypewriterTextAnimation extends StatefulWidget {
  final String text;
  final Duration duration;
  final BoxConstraints? constraints;

  TypewriterTextAnimation({
    required this.text,
    required this.duration,
    this.constraints,
  });

  @override
  _TypewriterTextAnimationState createState() =>
      _TypewriterTextAnimationState();
}

class _TypewriterTextAnimationState extends State<TypewriterTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _textAnimation = IntTween(begin: 0, end: widget.text.length)
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _textAnimation,
      builder: (context, child) {
        final animatedText = widget.text.substring(0, _textAnimation.value);
        return Container(
          constraints: widget.constraints,
          child: Text(animatedText, style: const TextStyle(fontSize: 18)),
        );
      },
    );
  }
}

