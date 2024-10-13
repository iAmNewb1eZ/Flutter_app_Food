class Foods {
  String? referenceId; // เพิ่มตัวแปรสำหรับเก็บ reference ID
  String table;
  List<Map<String, dynamic>> foodItems;
  DateTime timestamp;
  String? userId; // เพิ่มตัวแปรสำหรับเก็บ userId

  static const collectionName = 'orders';
  static const colReferenceId = 'referenceId'; // คอลัมน์ reference ID
  static const colTable = 'table';
  static const colFoodItems = 'foodItems';
  static const colTimestamp = 'timestamp';
  static const colUserId = 'userId'; // คอลัมน์ userId

  Foods({
    this.referenceId, // ให้เป็นตัวเลือก
    required this.table,
    required this.foodItems,
    required this.timestamp,
    this.userId, // ให้ userId เป็นตัวเลือก
  });

  // ฟังก์ชันแปลงข้อมูลเป็น JSON สำหรับเก็บใน Firestore
  Map<String, dynamic> toJson() {
    return {
      colTable: table,
      colFoodItems: foodItems,
      colTimestamp: timestamp.toIso8601String(),
      colUserId: userId, // เพิ่ม userId ใน JSON
    };
  }

  // ฟังก์ชันสร้าง Foods จาก JSON
  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(
      referenceId: json[colReferenceId], // อ่าน reference ID
      table: json[colTable],
      foodItems: List<Map<String, dynamic>>.from(json[colFoodItems]),
      timestamp: DateTime.parse(json[colTimestamp]),
      userId: json[colUserId], // อ่าน userId จาก JSON
    );
  }
}
