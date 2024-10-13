import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import สำหรับ UserAuthentication
import 'order.dart'; // Import โมเดล Foods

class DatabaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Authentication instance
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection(Foods.collectionName);

  // ตรวจสอบการเข้าสู่ระบบ (SignIn) ผู้ใช้ด้วย Email และ Password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      return user != null;
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      return false;
    }
  }

  // เพิ่มคำสั่งซื้อเข้า Firestore
  Future<DocumentReference> insertOrder(Foods order) async {
    try {
      final currentUser = _auth.currentUser; // ตรวจสอบว่ามีผู้ใช้เข้าสู่ระบบหรือไม่
      if (currentUser == null) {
        throw Exception('User not logged in');
      }

      order.userId = currentUser.uid; // บันทึก userId ใน order

      return orderCollection.add(order.toJson()).then((docRef) {
        order.referenceId = docRef.id; // อัปเดต reference ID ของ order
        return docRef;
      });
    } catch (e) {
      print("Error adding order: $e");
      rethrow; // ส่งข้อผิดพลาดกลับไป
    }
  }

  // อัปเดตคำสั่งซื้อใน Firestore
  Future<void> updateOrder(Foods order) async {
    try {
      await orderCollection.doc(order.referenceId).update(order.toJson());
    } catch (e) {
      print("Error updating order: $e");
      rethrow;
    }
  }

  // ดึงข้อมูลคำสั่งซื้อจาก Firestore
  Stream<QuerySnapshot> getOrderStream() {
    return orderCollection.snapshots();
  }

  // ค้นหาคำสั่งซื้อจากหมายเลขโต๊ะ
  Future<QuerySnapshot> searchOrderByTable(String table) async {
    try {
      return orderCollection.where('table', isEqualTo: table).get();
    } catch (e) {
      print("Error searching orders: $e");
      rethrow;
    }
  }

  // อัปเดตสถานะคำสั่งซื้อ
  Future<void> updateOrderStatus(String orderId, bool isCompleted) async {
    try {
      await orderCollection.doc(orderId).update({'isCompleted': isCompleted});
    } catch (e) {
      print("Error updating order status: $e");
      rethrow;
    }
  }

  // ค้นหาสินค้าจากชื่อ
  Future<QuerySnapshot> searchProduct(String searchValue) async {
    try {
      return FirebaseFirestore.instance
          .collection('products') // เปลี่ยนให้ตรงกับชื่อ collection ของคุณ
          .where('name', isEqualTo: searchValue)
          .get();
    } catch (e) {
      print("Error searching product: $e");
      rethrow;
    }
  }

  // ลบคำสั่งซื้อ
  Future<void> deleteOrder(String orderId) async {
    try {
      await orderCollection.doc(orderId).delete();
    } catch (e) {
      print("Error deleting order: $e");
      rethrow;
    }
  }
}
