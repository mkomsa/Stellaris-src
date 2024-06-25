import 'package:stellaris_app/models/news/news_info.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<NewsInfo> dummyNews = [];

//TODO should be handled as provider
void loadSpaceNews() async {
  try {
    List<NewsInfo> spaceNews = await fetchSpaceNews();
    dummyNews = spaceNews;
    // Now you can use dummyNews which contains the fetched space news
  } catch (e) {
    // Handle the error appropriately
  }
}

Future<List<NewsInfo>> fetchSpaceNews() async {
  final response = await http.get(
      Uri.parse('https://10.0.2.2:7014/api/space-news')); //callback interface

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => NewsInfo.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load space news');
  }
}



//   const NewsInfo(
//     title: "Mars Rover Discovers Ancient Riverbed",
//     content:
//         "The latest findings from the Mars rover reveal an astonishing discovery: an ancient riverbed believed to have once flowed with liquid water, suggesting the possibility of past habitability. \n \n The Mars rover, equipped with state-of-the-art instruments, has provided scientists with unprecedented insights into the Martian landscape. Detailed analysis of the captured images and data points to the existence of an ancient riverbed, a remnant of a time when liquid water may have cascaded across the Martian surface.\n \nThis revelation holds significant implications for our understanding of Mars' geological history and the potential for past habitability. The presence of an ancient riverbed indicates that Mars, at some point in its distant past, may have had conditions suitable for liquid water—a key ingredient for the emergence of life as we know it.\n \nScientists are now delving into the data to uncover more details about the characteristics of the ancient river and the timeframe during which it was active. The Mars rover's ongoing mission includes further exploration of the region, conducting additional analyses, and searching for additional clues that could shed light on Mars' aqueous history.\n \nThe discovery of an ancient riverbed adds another layer to the complex narrative of Mars' evolution. It fuels scientific curiosity and underscores the need for continued exploration to unlock the secrets hidden within the Martian landscape. As we peel back the layers of Mars' history, each revelation brings us closer to unraveling the mysteries of this neighboring planet and its potential for hosting conditions conducive to life.",
//     readTime: "5",
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/d/d8/NASA_Mars_Rover.jpg',
//     icon: Icons.explore,
//     category: NewsCategory.exploration,
//   ),
//   const NewsInfo(
//     title: "Breakthrough in Martian Soil Analysis",
//     content:
//         "Scientists have achieved a groundbreaking milestone in the exploration of Martian terrain. Recent data analysis has unveiled compelling evidence of organic compounds within the Martian soil. This discovery has ignited considerable excitement and renewed enthusiasm among scientists and space enthusiasts alike as it raises tantalizing possibilities in the ongoing quest to uncover signs of extraterrestrial life beyond our home planet. \n \n The identification of organic compounds in Martian soil represents a key step forward in our understanding of the Red Planet's geology and astrobiology. Organic compounds, which contain carbon-hydrogen bonds, are essential building blocks for life as we know it on Earth. While the presence of organic molecules doesn't confirm the existence of life, it provides a crucial foundation for future investigations into the potential habitability of Mars. \n \n  Researchers utilized advanced analytical techniques, including sophisticated instruments onboard robotic missions and orbiting satellites, to examine the composition of Martian soil samples. The data obtained not only confirms the presence of organic compounds but also hints at the complexity of these molecules, adding another layer to the intriguing puzzle of Martian chemistry.\n This breakthrough has far-reaching implications for upcoming missions to Mars, as scientists now have a more informed target for exploring regions with a higher likelihood of harboring signs of past or present life. The discovery fuels optimism and underscores the importance of continued exploration and scientific inquiry into the mysteries of our neighboring planet. \n \n  As space agencies and researchers around the world collaborate to unravel the secrets of Martian soil, this significant leap in our understanding opens new doors to uncovering the potential habitability of Mars and broadens the scope of humanity's exploration of the cosmos. The quest for life beyond Earth takes a promising turn with each new revelation, bringing us closer to answering one of the most profound questions:\n \nAre we alone in the universe?",
//     readTime: "3",
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/d/dc/PIA17944-MarsCuriosityRover-AfterCrossingDingoGapSanddune-20140209.jpg',
//     icon: Icons.science,
//     category: NewsCategory.science,
//   ),
//   const NewsInfo(
//     title: "New Technology Aids Mars Colonization Efforts",
//     content:
//         "Cutting-edge technology designed specifically for Martian conditions promises to revolutionize colonization efforts. With advancements in life support systems and habitat construction, the dream of settling on Mars is becoming more tangible.",
//     readTime: "7",
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/6/6e/Martian_habitat_with_colonists.jpg',
//     icon: Icons.build,
//     category: NewsCategory.colonization,
//   ),
//   const NewsInfo(
//     title: "Martian Weather Patterns Discovered",
//     content:
//         "In the vast expanse of the Martian frontier, recent observations from orbiters have unveiled a captivating revelation — the discovery of intricate weather patterns on the Red Planet. These findings, gleaned from meticulous scrutiny of Mars' atmospheric dynamics, represent a pivotal leap forward in our understanding of the enigmatic world beyond our own. \n \n The Martian weather patterns, meticulously deciphered through advanced observation technologies, weave a narrative of atmospheric phenomena that rival the complexity of Earth. From swirling dust storms that dance across the rust-colored terrain to the gentle caress of winds sculpting the Martian landscape, each weather pattern paints a portrait of a dynamic and ever-changing Martian climate. \n \n These observations not only quench our thirst for knowledge about the Martian atmosphere but also hold the key to unlocking the mysteries that shroud the planet. Scientists and researchers, captivated by these revelations, are now armed with a deeper understanding of the atmospheric intricacies that govern Mars. \n \n The significance of this discovery extends beyond mere scientific curiosity; it lays the groundwork for future missions to the Red Planet. Armed with a wealth of insights into Martian weather patterns, space agencies can fine-tune their strategies and preparations, ensuring that upcoming missions navigate the Martian atmosphere with precision and foresight. \n \n As we delve deeper into the atmospheric tapestry of Mars, each weather pattern becomes a chapter in the ongoing saga of exploration and discovery. The Red Planet, once seen as an otherworldly enigma, is gradually revealing its secrets through the lens of orbiters and the collective curiosity of humankind. \n \n These weather revelations mark a crucial milestone in our quest to comprehend the Martian landscape. They beckon us to peer beyond the surface and into the very heart of Mars, where atmospheric ballets and meteorological symphonies unfold in a cosmic dance. The journey to understand Martian weather patterns is not only a scientific endeavor but a testament to our insatiable thirst for knowledge and the boundless frontiers of exploration that await us in the celestial tapestry of our cosmic neighbor.",
//     readTime: "4",
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/0/0d/PIA17940-MartianMorningClouds-VikingOrbiter1-1976-20140212.jpg',
//     icon: Icons.cloud,
//     category: NewsCategory.environment,
//   ),
//   const NewsInfo(
//     title: "Mars in Ancient Mythology",
//     content:
//         "Embark on a captivating exploration into the intricate tapestry of ancient myths, where Mars, the Red Planet, takes center stage as a celestial deity woven into the very fabric of diverse cultures. Across the epochs, civilizations across the globe have bestowed upon Mars a sacred status, incorporating it into the rich lore and mythologies that define their worldview. \n \n Each culture has painted its own unique portrait of Mars, attributing distinct qualities and narratives to this enigmatic celestial body. Whether cast as a god of war, a symbol of love, or a harbinger of cosmic forces, the Red Planet has inspired a myriad of fascinating tales and legends that have transcended time.\n \n In the annals of history, Mars becomes more than just a distant celestial body; it transforms into a divine entity entangled with the collective consciousness of civilizations. From ancient Mesopotamia to classical Greece, from the grandeur of Egyptian mythology to the depths of Hindu cosmology, Mars has left an indelible mark on the cultural imagination.\n \n Uncover the mystique of Mars as it manifests in the myths and stories handed down through generations. Immerse yourself in narratives that speak of cosmic battles, celestial alignments, and the ever-shifting dance between the heavens and the Earth. Each myth is a testament to humanity's timeless fascination with the cosmos and our relentless pursuit of meaning in the celestial spheres.\n \n As we peel back the layers of ancient mythology surrounding Mars, we unveil a kaleidoscope of beliefs and interpretations that transcend geographical boundaries. The Red Planet, with its fiery glow, has sparked the creative minds of poets, storytellers, and visionaries throughout the ages, leaving an enduring legacy that continues to captivate the imagination.\n \n So, join this cosmic odyssey and traverse the realms of ancient myths, where Mars stands as an enduring symbol of the mystical and the divine. Unearth the cultural nuances and diverse perspectives that have sculpted Mars into a celestial deity, casting its radiant influence across the vast panorama of human mythology.",
//     readTime: "6",
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/9/94/Bacchus_and_Silenus_BM_1899.2-15.1_n01.jpg',
//     icon: Icons.book,
//     category: NewsCategory.culture,
//   ),
// ];