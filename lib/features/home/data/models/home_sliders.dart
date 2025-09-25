/*
{
   "_id": "680d16ca408c2a3e015a83b0",
   "photo_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbpR5UwmiL1npP790Q-3rPsAm18AMvUk180ixGC44Kwy-eCMC_OwE15SpK3PHSeqRuTqk&usqp=CAU",
   "description": "Iphone 16 pro",
   "product": null,
   "brand": "679a05182b11cd5ff18023e9",
   "category": null,
   "createdAt": "2025-04-26T17:24:26.803Z",
   "updatedAt": "2025-04-26T17:24:26.803Z",
   "__v": 0
},
*/

class HomeSliders {
  final String id;
  final String photoUrl;
  final String description;
  final String brandId;

  HomeSliders({
    required this.id,
    required this.photoUrl,
    required this.description,
    required this.brandId,
  });

  factory HomeSliders.fromJson(Map<String, dynamic> jsonData) {
    return HomeSliders(
      id: jsonData['_id'],
      photoUrl: jsonData['photo_url'],
      description: jsonData['description'],
      brandId: jsonData['brand'],
    );
  }
}
