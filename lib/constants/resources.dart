
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import 'app_images.dart';

String BaseURL = dotenv.env['PROD_URL']!;
String getCurrency() {
  return '₦'; // Unicode character for Naira symbol
}
 var photoHolder = 'https://picsum.photos/200';
String WebsocketURL=dotenv.env['WSS_URL']!;
String APIKEY = dotenv.env['API_KEY']!; 
String WebsocketAPIKEY =dotenv.env["WEBSOCKET_API_KEY"]!;

const String aboutUs =
    "We are tackling the problems of access to and cost of quality medication especially for patients with Non communicable diseases in Nigeria. We are operational in the cities of Enugu and Lagos state at this time. Other states coming soon!";
const String aboutUs1 =
    "Pharmplug is an online pharmacy and telemedicine platform. We make it easy and convenient for people to order and refill their prescription. We work with different standard community and wholesale pharmacies around the country. No more driving around different pharmacies looking for an out-of-stock medicine; Pharmplug has got this covered.";

const String aboutUs2 =
    "Non communicable disease, NCDs management is cheaper with pharmplugWe pay special attention to our patients that have chronic medical conditions. That is, patients who suffer from diabetes, chronic pain, hypertension, erectile dysfunction, cancer etc, can now get their prescription at a whopping 15% discount for life! We know the impact of buying drugs on a monthly basis and we choose to make it easier for people.";

const String aboutUs3 =
    "We work with different PCN and Nafdac approved community and wholesale pharmacies in Nigeria after assessing their modes of procurement and storage methods. We have a standard level agreement with the facilities as concerns packaging because our patients privacy is of high priority to us.When we get an order from you, our operations personnel quickly process it and send to a pharmacy closest to you. You can then just walk into the pharmacy and pick up your medications or choose from other measures we have for pick up.";

const String aboutUs4 =
    "Our interest is not just selling or dispensing drugs to you. We are more focused on ensuring you use your medications the right way and that you don't have adverse drug reactions especially from interactions from other multiple drugs you use or from foods or food supplements you take.Therefore, we have a full scale medication therapy management services for our patients, especially the ones on chronic treatment. We provide answers and emergency interventions during the periods between your doctor appointment, ensure you take your drugs the right way, assess and evaluate your complete medication therapy, detect adverse drug reactions, prevent medication errors and making suggestions for cheaper alternatives. Our pharmacists are enthusiastic to follow up on you!";

const String aboutUs5 =
    "Our promise is to ensure the availability of all your medications, package and conceal your medications in the right conditions of storage and get them to you in good condition. Seat back and relax while we remember your refill dates...Please use the auto refill button";

const String termsandcondions =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vitae viverra quam. Nullam tincidunt nulla libero, sed pretium nibh gravida sed. Morbi vulputate tellus nec placerat dignissim. Quisque blandit mollis nisi, ut cursus lacus tempor et. Fusce scelerisque, turpis nec suscipit egestas, libero lacus sollicitudin dolor, non eleifend est elit id massa. Quisque tempus, dui eu imperdiet finibus, libero sem cursus arcu, at imperdiet neque est eget purus. Sed vitae purus sed magna sollicitudin commodo. Morbi suscipit nulla ultrices eleifend malesuada. Nam euismod lacus eget varius tincidunt. Sed elementum diam eget convallis gravida Sed risus nisl, finibus sit amet massa et, suscipit posuere enim. Maecenas id quam sapien. Nunc commodo nibh a aliquet tempus. Vivamus lacus purus, varius id posuere vulputate, pellentesque nec quam. Aliquam dapibus egestas orci et aliquet. Suspendisse vitae gravida orci, non mollis neque. Duis sagittis, urna nec luctus mattis, metus turpis aliquet nisl, quis convallis ipsum nisi suscipit magna. Phasellus id est rutrum, lobortis turpis eu, feugiat augue. Donec ac pulvinar massa. Quisque leo dui, facilisis eget nibh ac, ultrices tempor nibh. Cras viverra est sagittis pulvinar congue. Mauris sagittis eros a nunc aliquet, finibus ullamcorper mauris porttitor. Mauris consequat porttitor urna eget sagittis. Ut quis dui id diam fermentum elementum id in nisl. Nulla convallis cursus quam, et pellentesque lorem semper id. Aenean sed sapien ultrices, facilisis turpis vitae, pulvinar elit Pellentesque eu diam congue, varius tellus hendrerit, aliquet tellus. Integer molestie tempor ex quis vehicula. In pulvinar rutrum finibus. Ut sed porta risus, non tempus dolor. Aenean vel sem mi. Integer nulla velit, sagittis a ultrices ac, pellentesque a sem. Suspendisse ipsum felis, condimentum sit amet libero nec, porttitor vestibulum tellus. Aliquam erat volutpat. Suspendisse eu accumsan lacus. Duis eu lacus sodales est sollicitudin rhoncus volutpat et sapien. Nam hendrerit, turpis posuere tristique lobortis, erat magna porttitor sem, venenatis pretium felis odio a dolor. Vivamus sed dapibus tellus. Nulla vehicula lectus non metus hendrerit euismod. Duis ornare posuere quam, in rhoncus leo auctor quis. In congue purus sit amet justo consectetur lobortis Donec nulla eros, dignissim ac finibus in, ultrices sit amet purus. Nullam rhoncus, risus et consequat sodales, mauris dolor tempus nisi, eget vehicula tortor lorem ac nisl. Aliquam eget finibus est. Suspendisse sed est pellentesque, posuere nisi nec, lobortis urna. Phasellus ornare nisl aliquam, sodales ipsum sed, interdum mauris. Sed posuere, enim accumsan sollicitudin dignissim, felis orci lobortis nulla, in tincidunt neque dolor ut enim. Phasellus varius erat at ante malesuada feugiat. Sed euismod urna sit amet lacinia bibendum.Pellentesque condimentum lectus nulla, vel egestas neque facilisis vel. Etiam id pretium mi, ac sagittis odio. Nullam eget eleifend massa, nec ultrices justo. Ut laoreet quam mi, eget faucibus quam tincidunt ac. Vestibulum id condimentum ipsum, pulvinar pellentesque orci. Maecenas dui est, posuere in tempus id, accumsan sit amet lorem. Curabitur scelerisque, nisi eu viverra dignissim, metus mi malesuada sapien, id cursus ex sapien vel orci. Vestibulum quis imperdiet risus. Nam orci nibh, dignissim quis dictum rutrum, condimentum sit amet orci. Proin aliquam tincidunt faucibus.';

const String policytext =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vitae viverra quam. Nullam tincidunt nulla libero, sed pretium nibh gravida sed. Morbi vulputate tellus nec placerat dignissim. Quisque blandit mollis nisi, ut cursus lacus tempor et. Fusce scelerisque, turpis nec suscipit egestas, libero lacus sollicitudin dolor, non eleifend est elit id massa. Quisque tempus, dui eu imperdiet finibus, libero sem cursus arcu, at imperdiet neque est eget purus. Sed vitae purus sed magna sollicitudin commodo. Morbi suscipit nulla ultrices eleifend malesuada. Nam euismod lacus eget varius tincidunt. Sed elementum diam eget convallis gravida Sed risus nisl, finibus sit amet massa et, suscipit posuere enim. Maecenas id quam sapien. Nunc commodo nibh a aliquet tempus. Vivamus lacus purus, varius id posuere vulputate, pellentesque nec quam. Aliquam dapibus egestas orci et aliquet. Suspendisse vitae gravida orci, non mollis neque. Duis sagittis, urna nec luctus mattis, metus turpis aliquet nisl, quis convallis ipsum nisi suscipit magna. Phasellus id est rutrum, lobortis turpis eu, feugiat augue. Donec ac pulvinar massa. Quisque leo dui, facilisis eget nibh ac, ultrices tempor nibh. Cras viverra est sagittis pulvinar congue. Mauris sagittis eros a nunc aliquet, finibus ullamcorper mauris porttitor. Mauris consequat porttitor urna eget sagittis. Ut quis dui id diam fermentum elementum id in nisl. Nulla convallis cursus quam, et pellentesque lorem semper id. Aenean sed sapien ultrices, facilisis turpis vitae, pulvinar elit Pellentesque eu diam congue, varius tellus hendrerit, aliquet tellus. Integer molestie tempor ex quis vehicula. In pulvinar rutrum finibus. Ut sed porta risus, non tempus dolor. Aenean vel sem mi. Integer nulla velit, sagittis a ultrices ac, pellentesque a sem. Suspendisse ipsum felis, condimentum sit amet libero nec, porttitor vestibulum tellus. Aliquam erat volutpat. Suspendisse eu accumsan lacus. Duis eu lacus sodales est sollicitudin rhoncus volutpat et sapien. Nam hendrerit, turpis posuere tristique lobortis, erat magna porttitor sem, venenatis pretium felis odio a dolor. Vivamus sed dapibus tellus. Nulla vehicula lectus non metus hendrerit euismod. Duis ornare posuere quam, in rhoncus leo auctor quis. In congue purus sit amet justo consectetur lobortis Donec nulla eros, dignissim ac finibus in, ultrices sit amet purus. Nullam rhoncus, risus et consequat sodales, mauris dolor tempus nisi, eget vehicula tortor lorem ac nisl. Aliquam eget finibus est. Suspendisse sed est pellentesque, posuere nisi nec, lobortis urna. Phasellus ornare nisl aliquam, sodales ipsum sed, interdum mauris. Sed posuere, enim accumsan sollicitudin dignissim, felis orci lobortis nulla, in tincidunt neque dolor ut enim. Phasellus varius erat at ante malesuada feugiat. Sed euismod urna sit amet lacinia bibendum.Pellentesque condimentum lectus nulla, vel egestas neque facilisis vel. Etiam id pretium mi, ac sagittis odio. Nullam eget eleifend massa, nec ultrices justo. Ut laoreet quam mi, eget faucibus quam tincidunt ac. Vestibulum id condimentum ipsum, pulvinar pellentesque orci. Maecenas dui est, posuere in tempus id, accumsan sit amet lorem. Curabitur scelerisque, nisi eu viverra dignissim, metus mi malesuada sapien, id cursus ex sapien vel orci. Vestibulum quis imperdiet risus. Nam orci nibh, dignissim quis dictum rutrum, condimentum sit amet orci. Proin aliquam tincidunt faucibus.';

var formatter = NumberFormat('#,##,000');

String customFormatCurrency(int number) {
  if (number >= 1000) {
    var formatter = NumberFormat('#,###');
    return formatter.format(number);
  } else {
    return number.toString();
  }
}

const imgHolder =
    "https://i.ibb.co/GtsgGKg/d5d5ce76ff5f.jpg";


List<Map> services = [
  {
    'icon': AppImages.electrician,
    'color': Color(0xFFFCEADA),
    'color2': Color(0xFFEF9645),
    'text': 'Electrician',
    'job': ["Install lights", "Install appliances"]
  },
  {
    'icon': AppImages.plumber,
    'color': Color(0xFFEADAFF),
    'color2': Color(0xFF9747FF),
    'text': 'Plumber',
    'job': ["Fix broken tap", "Fix leaking sink"]
  },
  {
    'icon': AppImages.fumigator,
    'color': Color(0xFFFFE4E9),
    'color2': Color(0xFFFF7892),
    'text': 'Fumigator',
    'job': ["Fumigate house", "Fumigate compound"]
  },
  {
    'icon': AppImages.cleaner,
    'color2': Color(0xFFEA4335),
    'color': Color(0xFFFBD9D7),
    'text': 'Cleaner',
    'job': ["Clean house"]
  },
  {
    'icon': AppImages.painter,
    'color2': const Color(0xFF22DBBA),
    'color': Color(0xFFD3F8F1),
    'text': 'Painter',
    'job': ['Painting']
  },
  {
    'icon':AppImages.agent,
    'color2': Color(0xFFFF5F00),
    'color': Color(0xFFFFDFCC),
    'text': 'Gardener',
    'job': ["Cut grass", "Hedge Trimming"]
  },
  {
    'icon': AppImages.movers,
    'color2': Color(0xFF750790),
    'color': Color(0xFFE3CDE9),
    'text': 'Mover',
    'job': ["Request mover"]
  },
  {
    'icon': AppImages.agent,
    'color2': Color(0xFF5DADEC),
    'color': Color(0xFFDFEFFB),
    'text': 'Carpenter',
    'job': ['Carpentry works']
  },
];

  
   List<Map<String, dynamic>> priority = [
  {
    "type": "High Priority",
    'color': Color(0xFFEB5757),
    'color2': Color(0xFFFCE6E6)
  },
  {
    "type": "Medium Priority",
    'color': Color(0xFFF2994A),
    'color2': Color.fromARGB(255, 255, 242, 231),
  },
  {
    "type": "Low Priority",
    'color': Color(0xFFF2C94C),
    'color2': Color.fromARGB(255, 255, 247, 222),
  },
  {
    "type": "None",
    'color': Color(0xFF2D9CDB),
    'color2': Color.fromARGB(255, 228, 245, 255),
  },
];
