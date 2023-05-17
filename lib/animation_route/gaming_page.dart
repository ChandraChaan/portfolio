import 'package:flutter/material.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  TextEditingController inputController = TextEditingController();
  String _text = "Type Something";
  String replyTest = "See The Result";
  bool showTable = false;
  bool container = false;
  bool circle = false;
  int rNumber = 0;

  Map getReplayList = {
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

  _getReply() {
    final String userGivenText = inputController.text;
    if (userGivenText.isNotEmpty) {
      String rText = '';
      String userText = userGivenText.toLowerCase();
      if (userGivenText.isNumeric) {
        rNumber = int.parse(userGivenText);
        rText = (2 * rNumber).toString();
        showTable = true;
        container = false;
        circle = false;
      } else {
        showTable = false;
        List name = userGivenText.split(' ');
        if (name[0].toString().toLowerCase() == 'create') {
          if (name[1].toString().toLowerCase() == 'container') {
            container = true;
            circle = false;
          } else if (name[1].toString().toLowerCase() == 'circle') {
            container = false;
            circle = true;
          } else {
            container = false;
            circle = false;
            rText = "I didn\'t get";
          }
        } else {
          container = false;
          circle = false;
        }
        List checkKeyList = getReplayList.keys.toList();
        for (int a = 0; a < checkKeyList.length; a++) {
          if (checkKeyList[a].toString().toLowerCase() ==
              userText.toLowerCase()) {
            return getReplayList[checkKeyList[a]];
          }
        }
      }
      setState(() {
        replyTest = rText;
        inputController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to time pass game'),
      ),
      body: Row(
        children: [
          // side menu
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    children: [
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              width: 150,
                              child: Center(child: Text(_text)))),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              width: 150,
                              child: Center(child: Text(replyTest)))),
                      if (circle || container)
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: circle
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                borderRadius: container
                                    ? BorderRadius.circular(12)
                                    : null,
                              ),
                              height: 150,
                              width: 150,
                              // child: Center(child: Text(replyTest))
                            )),
                    ],
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showTable)
            // body
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int a = 1; a < 11; a++)
                      Text('$_text x $a = ${(a * rNumber).toString()}')
                    // Text('$_text'
                    //     'x ${a.toString()} = ${(int.parse(inputController.text) * a).toString()}'),
                  ],
                )),
        ],
      ),
    );
  }
}

extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
}
