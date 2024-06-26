//
//  AuthViewModel.swift
//  Teachers Pet
//
//

//This file will be responsible for having all functionality to updating the backend with user
//for instance, email and password.

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestoreSwift
import FirebaseFirestore


@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var positionInLine: Int = 0
    @Published var courseName: String = ""
    @Published var joinCode: String = ""
    @Published var allStudentsinoh: [(uid: String, fullname: String)] = []
    
    let db = Firestore.firestore()
    

    
    func saveData(name: String) async throws {
        guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else {
            print("Device UUID not available")
            return
        }
        
        //let db = Firestore.firestore()
        let userDocRef = db.collection("users").document(deviceUUID)
        let drugTypeCollectionRef = userDocRef.collection("drugTypes")
        let dataDict: [String: Any] = ["drugName": name]
        
        do {
            // Check if the user document exists, create it if it doesn't
            let documentSnapshot = try await userDocRef.getDocument()
            if !documentSnapshot.exists {
                // If it doesn't exist, create an empty document
                try await userDocRef.setData([:])
            }
            // Save drug name and type to Firestore under the user's document
            try await drugTypeCollectionRef.addDocument(data: dataDict)
            print("Drug name and type saved successfully")
        } catch {
            print("Error saving drug name and type to Firestore: \(error.localizedDescription)")
            throw error
        }
    }
    
    
    
    func parseTextFile(filePath: String) throws -> String {
        // Read the contents of the file
        let fileContents = try String(contentsOfFile: filePath)
        
        // Use a regular expression to split the text into words
        let words = fileContents.split(whereSeparator: { !$0.isLetter })
        
        // Join the words into a single string
        let parsedString = words.joined(separator: " ")
        
        return parsedString
    }
    
    func getString(parsedInfo: String, ourWord: String) async throws {
        var currString = ""
        do {
            for (index, character) in parsedInfo.enumerated() {
                if character == " " || index == parsedInfo.count - 1 {
                    if currString != "" {
                        if currString == ourWord {
                            try await db.collection("yourCollection").addDocument(data: ["yourField": currString]) // fixed!
                            return
                        }
                        currString = ""
                        
                    }
                }
                else {
                    currString.append(character)
                }
            }
        }
        catch{
            print("we could not find the string :(")
            throw error
        }
    }
    
    
    func findPercentOver(correctDose: Double, myDose: Double) -> String {
            var percentOver = (myDose / correctDose) * 100
            return String(format: "%.2f", percentOver)
        }
    
    
    
    func saveActiveIngredients(ingredients: String) async {
        do {
            guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else {
                print("Device UUID not available")
                return
            }
            
            let userDocRef = db.collection("users").document(deviceUUID)
            let ingredientsCollectionRef = userDocRef.collection("ingredients")
            
            let dataDict: [String: Any] = ["ingredients": ingredients]
            
            try await ingredientsCollectionRef.addDocument(data: dataDict)
            print("Ingredients saved successfully")
        } catch {
            // Handle errors
            print("Error saving ingredients: \(error.localizedDescription)")
        }
    }

    
    func savedosage(dosage: String) async {
        guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else {
            print("Device UUID not available")
            return
        }
        
        let userDocRef = db.collection("users").document(deviceUUID)
        let dosageCollectionRef = userDocRef.collection("dosage")
        
        let dataDict: [String: Any] = ["dosage": dosage]
        
        do {
            // Perform the Firestore operation asynchronously
            try await dosageCollectionRef.addDocument(data: dataDict)
            print("Dosage saved successfully")
        } catch {
            // Handle errors
            print("Error saving dosage: \(error.localizedDescription)")
        }
    }

    
    func savedirections(directions: String) async {
        do {
            guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else {
                print("Device UUID not available")
                return
            }
            
            let userDocRef = db.collection("users").document(deviceUUID)
            let directionsCollectionRef = userDocRef.collection("directions")
            
            let dataDict: [String: Any] = ["directions": directions]
            
            try await directionsCollectionRef.addDocument(data: dataDict)
            print("Directions saved successfully")
        } catch {
            // Handle errors
            print("Error saving directions: \(error.localizedDescription)")
        }
    }
    
    
    func savecurrentdosage(currdosage: String) async {
        do {
            guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else {
                print("Device UUID not available")
                return
            }
            
            let userDocRef = db.collection("users").document(deviceUUID)
            let currentdosageCollectionRef = userDocRef.collection("current dosage")
            
            let dataDict: [String: Any] = ["current dosage": currdosage]
            
            try await currentdosageCollectionRef.addDocument(data: dataDict)
            print("Current Dosage saved")
        } catch {
            // Handle errors
            print("Current Dosage not saved bro: \(error.localizedDescription)")
        }
    }
    
    
    func Takecurrdosage(medicineName: String, currdosage: String) async {
        do {
            guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else {
                print("Device UUID not available")
                return
            }
            
            let userDocRef = db.collection("users").document(deviceUUID)
            let currentDosageCollectionRef = userDocRef.collection("current dosage")
            
            // Query the "current dosage" collection to find the document with the given medicine name
            let querySnapshot = try await currentDosageCollectionRef.whereField("medicineName", isEqualTo: medicineName).getDocuments()
            
            if let document = querySnapshot.documents.first {
                // If a document exists, retrieve the current dosage as a string
                let currentDosageData = document.data()
                if let currentDosageString = currentDosageData["current dosage"] as? String,
                   let currentDosage = Int(currentDosageString) {
                    print("Current Dosage retrieved for \(medicineName): \(currentDosage)")
                    // Now you can save the new dosage or handle it as needed
                }
            }
            
            // Save the new dosage
            let dataDict: [String: Any] = ["medicineName": medicineName, "current dosage": currdosage]
            try await currentDosageCollectionRef.addDocument(data: dataDict)
            print("New Dosage saved")
        } catch {
            // Handle errors
            print("Error: \(error.localizedDescription)")
        }
    }




   
    
    
//    //Methods for signing in and out of accounts.
//    func signIn(withEmail email: String, password: String) async throws {
//        do {
//            let result = try await Auth.auth().signIn(withEmail: email, password: password)
//            self.userSession = result.user
//            await fetchUser()
//        } catch {
//            throw error
//        }
//    }
//
//    func signInforStudents(withEmail email: String, password: String) async throws {
//        do {
//            let result = try await Auth.auth().signIn(withEmail: email, password: password)
//            self.userSession = result.user
//            await fetchStudentUserInfo()
//        } catch {
//            throw error
//        }
//    }
//
//
//    func signout() {
//        do {
//            try Auth.auth().signOut()
//            self.userSession = nil
//            self.currentUser = nil
//        } catch {
//            print("Failed to sign out")
//        }
//    }
//
//    //Methods for fetching users.
//    func fetchUser() async {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        guard let snapshot = try? await db.collection("users").document(uid).getDocument() else {return }
//        self.currentUser = try? snapshot.data(as: User.self)
//
//        print("Current user is \(self.currentUser)")
//
//    }
//
//    //Test Method For Allowing Signed In Students To Join The Office Hours Line.
//    func fetchStudentUserInfo() async {
//            guard let uid = Auth.auth().currentUser?.uid else { return }
//            do {
//                // Query the users collection to find all teacher documents
//                let teacherQuerySnapshot = try await db.collection("users").getDocuments()
//
//                // Iterate through the teacher documents
//                for teacherDocument in teacherQuerySnapshot.documents {
//                    // Get the reference to the student document within the teacher's students subcollection
//                    let studentDocumentRef = teacherDocument.reference.collection("students").document(uid)
//
//                    // Fetch the student document
//                    let studentDocumentSnapshot = try await studentDocumentRef.getDocument()
//
//                    // Check if the student document exists and matches the provided UID
//                    if let _ = studentDocumentSnapshot.data(), studentDocumentSnapshot.exists {
//                        // This teacher document contains the student with the provided UID
//                        self.currentUser = try? studentDocumentSnapshot.data(as: User.self)
//                        print("Teacher document found for student with UID \(uid): \(teacherDocument.data())")
//                    }
//                }
//            } catch {
//                print("Error fetching teacher documents: \(error.localizedDescription)")
//            }
//        }
//
//
//    func fetchTeacherDocumentsForStudent() async {
//            guard let uid = Auth.auth().currentUser?.uid else { return }
//            do {
//                // Query the users collection to find all teacher documents
//                let teacherQuerySnapshot = try await db.collection("users").getDocuments()
//
//                // Iterate through the teacher documents
//                for teacherDocument in teacherQuerySnapshot.documents {
//                    // Get the reference to the student document within the teacher's students subcollection
//                    let studentDocumentRef = teacherDocument.reference.collection("students").document(uid)
//
//                    // Fetch the student document
//                    let studentDocumentSnapshot = try await studentDocumentRef.getDocument()
//
//                    // Check if the student document exists and matches the provided UID
//                    if let studentData = studentDocumentSnapshot.data(), studentDocumentSnapshot.exists {
//                        // This teacher document contains the student with the provided UID
//                        print("Teacher document found for student with UID \(uid): \(teacherDocument.data())")
//                    }
//                }
//            } catch {
//                print("Error fetching teacher documents: \(error.localizedDescription)")
//            }
//        }
//
//    func getCourseName() async {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        do {
//            // Query the users collection to find all teacher documents
//            let teacherQuerySnapshot = try await Firestore.firestore().collection("users").getDocuments()
//
//            // Iterate through the teacher documents
//            for teacherDocument in teacherQuerySnapshot.documents {
//                // Get the reference to the student document within the teacher's students subcollection
//                let studentDocumentRef = teacherDocument.reference.collection("students").document(uid)
//
//                // Fetch the student document
//                let studentDocumentSnapshot = try await studentDocumentRef.getDocument()
//
//                // Check if the student document exists and matches the provided UID
//                if let _ = studentDocumentSnapshot.data(), studentDocumentSnapshot.exists {
//                    // This teacher document contains the student with the provided UID
//                    print("Teacher document found for student with UID \(uid): \(teacherDocument.data())")
//                    let data = teacherDocument.data()
//                    if let coursenameTemp = data["coursename"] as? String {
//                        // If coursename is not nil, print its value
//                        self.courseName = coursenameTemp
//                    } else {
//                        // If coursename is nil or not a String, print a message or handle the case accordingly
//                        print("coursename is nil or not a String")
//                    }
//                }
//            }
//        } catch {
//            print("Error fetching teacher documents: \(error.localizedDescription)")
//        }
//
//    }
//
//    func fetchTeacherDocumentsForTA() async {
//            guard let uid = Auth.auth().currentUser?.uid else { return }
//            do {
//                // Query the users collection to find all teacher documents
//                let teacherQuerySnapshot = try await db.collection("users").getDocuments()
//                // Iterate through the teacher documents
//                for teacherDocument in teacherQuerySnapshot.documents {
//                    // Get the reference to the student document within the teacher's TA subcollection
//                    let TADocRef = teacherDocument.reference.collection("TAs").document(uid)
//                    // Fetch the TA document
//                    let TADocumentSnapshot = try await TADocRef.getDocument()
//                    // Check if the TA document exists and matches the provided UID
//                    if let studentData = TADocumentSnapshot.data(), TADocumentSnapshot.exists {
//                        // This teacher document contains the student with the provided UID
//                        print("Teacher document found for TA with UID \(uid): \(teacherDocument.data())")
//                    }
//                }
//            } catch {
//                print("Error fetching teacher documents: \(error.localizedDescription)")
//            }
//        }
//
//    //Methods for creating users (main instructors, TAs, and students).
//    func createUser(withEmail email: String, password: String, fullname: String, coursename: String, joincode: String) async throws {
//        do {
//            let result = try await Auth.auth().createUser(withEmail: email, password: password) //create user using firebase code that we installed
//            self.userSession = result.user //if we get successful result back
//            let user = User(id: result.user.uid, fullname: fullname, email: email, coursename: coursename, joincode: joincode) //create our user object, from Model itself
//            let encodedUser = try Firestore.Encoder().encode(user) //encode that object through the encodable protocol, encodes into JSON data so that it can be stored into firebase
//            try await db.collection("users").document(user.id).setData(encodedUser) //upload data to firestore
//            await fetchUser()
//        } catch {
//            throw error
//
//        }
//    }
//
//    func canCreateInstructor(withEmail email: String) async throws -> Bool {
//        do {
//            // Check if the email is already in use
//            let emailExists = try await db.collection("users").whereField("email", isEqualTo: email).getDocuments()
//
//            if !emailExists.isEmpty {
//                //If email does exist return false
//                return false
//            }
//            //If the email does not exist return true
//            return true
//        } catch {
//            // If an error occurs, return false (to be safe)
//            return false
//        }
//    }
//
//
//
//
//    func canjoinClass(joinCode: String) async throws -> Bool {
//        do {
//            // Check if the email is already in use
//            let joinCodeexists = try await db.collection("users").whereField("joincode", isEqualTo: joinCode).getDocuments()
//            if !joinCodeexists.isEmpty {
//                //If email does exist return false
//                return false
//            }
//            //If the email does not exist return true
//            return true
//        } catch {
//            // If an error occurs, return false (to be safe)
//            return false
//        }
//    }
//
//
//
//    func createStudent(withEmail email: String, password: String, fullname: String, coursename: String, joincode: String) async throws {
//        do {
//            let result = try await Auth.auth().createUser(withEmail: email, password: password)
//            self.userSession = result.user
//
//            // Find the teacher document using the joincode
//            let teacherQuerySnapshot = try await db.collection("users").whereField("joincode", isEqualTo: joincode).getDocuments()
//
//            guard let teacherDocument = teacherQuerySnapshot.documents.first else {
//                print("Teacher with joincode \(joincode) not found")
//                //throw NSError(domain: "EROR", code: 101)
//                return
//            }
//
//            // Create the student user under the teacher's collection
//            let user = User(id: result.user.uid, fullname: fullname, email: email, coursename: coursename, joincode: joincode)
//            let encodedUser = try Firestore.Encoder().encode(user)
//            let teacherID = teacherDocument.documentID
//            try await db.collection("users").document(teacherID).collection("students").document(user.id).setData(encodedUser)
//
//            await fetchTeacherDocumentsForStudent()
//
//        } catch {
//            throw error
//        }
//    }
//
//    func createTA(withEmail email: String, password: String, fullname: String, joincode: String) async throws {
//        do {
//            let result = try await Auth.auth().createUser(withEmail: email, password: password)
//            self.userSession = result.user
//
//            // Find the teacher document using the joincode
//            let teacherQuerySnapshot = try await db.collection("users").whereField("joincode", isEqualTo: joincode).getDocuments()
//
//            guard let instructorDocument = teacherQuerySnapshot.documents.first else {
//                print("Teacher with joincode \(joincode) not found")
//                return
//            }
//
//            let instructorData = instructorDocument.data()
//            guard let courseName = instructorData["coursename"] as? String else {
//                print("No Coursename found")
//                return
//            }
//
//            // Create the student user under the teacher's collection
//            let user = User(id: result.user.uid, fullname: fullname, email: email, coursename: courseName, joincode: "")
//            let encodedUser = try Firestore.Encoder().encode(user)
//            let instructorID = instructorDocument.documentID
//            try await db.collection("users").document(instructorID).collection("TAs").document(user.id).setData(encodedUser)
//
//            await fetchTeacherDocumentsForTA()
//
//        } catch {
//            print("Failed to create TA user: \(error.localizedDescription)")
//        }
//    }
//
//    func addStudentToLine(joinCode: String, email: String) async throws -> Bool {
//        guard let currentUser = self.userSession?.uid else {
//            print("user does not exist")
//            return false
//        }
//
//        do {
//           //Retrieve the instructor document with the same join code.
//            let professorQuerySnapshot = try await db.collection("users").whereField("joincode", isEqualTo: joinCode).getDocuments()
//
//            // Users -> UID -> Students
//            //Fetches the instructor with the corresponding join code.
//            guard let professorDocument = professorQuerySnapshot.documents.first else {
//                print("Professor not found")
//                return false
//            }
//
//            //Retrieve the ID of the instructor document
//            let professorID = professorDocument.documentID
//
//
//            let officehoursCollection = db.collection("users").document(professorID).collection("Office Hours")
//
//            let officehourstudents = try await officehoursCollection.whereField("id", isEqualTo: currentUser).getDocuments()
//
//            if officehourstudents.isEmpty {
//                //Get all of the students in the instructor's course.
//                let studentsInCourse = try await db.collection("users").document(professorID).collection("students").getDocuments()
//
//                //For all the students under the instructor, get their data (name, email, etc.). Then check if the logged in student's ID in Firebase is the same ID that is under the instructor. If they match, add that student to the Office Hours collection.
//                for studentDocument in studentsInCourse.documents {
//                    var studentData = studentDocument.data()
//
//                    if studentData["id"] as? String == currentUser {
//                        studentData["entryDate"] = Timestamp()
//                        try await officehoursCollection.addDocument(data: studentData)
//                        return false
//                    }
//
//                }
//            } else {
//                return true
//            }
//
//            await fetchTeacherDocumentsForStudent()
//
//
//        } catch {
//            return false
//        }
//
//        return false
//    }
//
//    //Methods related to managing the office hours line.
//    func calculateLinePosition(joinCode: String, email: String) async throws {
//        guard let currentUser = self.userSession?.uid else {
//            print("user does not exist")
//            return
//        }
//        do {
//            //Retrieve the instructor document with the same join code.
//             let professorQuerySnapshot = try await db.collection("users").whereField("joincode", isEqualTo: joinCode).getDocuments()
//
//             // Users -> UID -> Students
//             //Fetches the instructor with the corresponding join code.
//             guard let professorDocument = professorQuerySnapshot.documents.first else {
//                 print("Professor not found")
//                 return
//             }
//
//             //Retrieve the ID of the instructor document
//            let professorID = professorDocument.documentID
//            let officehoursCollection = db.collection("users").document(professorID).collection("Office Hours")
//
//             //Get all of the students in the instructor's course.
//            let studentsInOfficeHours = try await officehoursCollection.order(by: "entryDate").getDocuments()
//
//             //For all the students under the instructor, get their data (name, email, etc.). Then check if the logged in student's ID in Firebase is the same ID that is under the instructor. If they match, exit the loop and return the student's position in line.
//            var linePosition = 1
//             for student in studentsInOfficeHours.documents {
//                 var studentData = student.data()
//
//                 if studentData["id"] as? String == currentUser {
//                     try await student.reference.updateData(["linePosition" : linePosition])
//                     self.positionInLine = linePosition
//                     return
//                 } else {
//                     try await student.reference.updateData(["linePosition" : linePosition])
//                     linePosition += 1
//
//                 }
//             }
//
//        } catch {
//            print("Issue with calculating line position: \(error.localizedDescription)")
//        }
//
//    }
//
//    //To be implemented.
//     func removeStudentFromLine(joinCode: String, email: String) async throws {
//
//         var currentLinePosition = 0;
//         guard let currentUser = self.userSession?.uid else {
//             print("user does not exist")
//             return
//       }
//
//       do {
//           // Retrieve the instructor document with the same join code.
//           let professorQuerySnapshot = try await Firestore.firestore().collection("users").whereField("joincode", isEqualTo: joinCode).getDocuments()
//
//           // Users -> UID -> Students
//           // Fetches the instructor with the corresponding join code.
//           guard let professorDocument = professorQuerySnapshot.documents.first else {
//               print("Professor not found")
//               return
//           }
//
//           // Retrieve the ID of the instructor document
//           let professorID = professorDocument.documentID
//           let officehoursCollection = db.collection("users").document(professorID).collection("Office Hours")
//
//           // Get the reference to the student's document in the "Office Hours" collection
//           let studentDocumentReference = officehoursCollection.document(currentUser)
//
//           do {
//               //get all the documents with userID in office hours
//               let studentQuerySnapshot = try await officehoursCollection.whereField("id", isEqualTo: studentDocumentReference.documentID).getDocuments()
//
//
//               //Removing the student
//               for document in studentQuerySnapshot.documents {
//                   var studentData = document.data()
//                   //get the removed student's position in line.
//                   if let linePosition = studentData["linePosition"] as? Int {
//                       currentLinePosition = linePosition
//                   }
//                   try await document.reference.delete()
//                   print("Document \(document.documentID) deleted successfully.")
//               }
//           } catch {
//               print("Error deleting documents: \(error)")
//           }
//
//            //Get all of the students in the instructor's course.
//           let studentsInOfficeHours = try await officehoursCollection.order(by: "entryDate").getDocuments()
//
//           for student in studentsInOfficeHours.documents {
//               var studentData = student.data()
//
//               guard let studentLinePosition = studentData["linePosition"] as? Int else {
//                   print("could not find the line position...")
//                   return
//               }
//
//               if studentLinePosition > currentLinePosition {
//                   try await student.reference.updateData(["linePosition" : (studentLinePosition - 1)])
//                   self.positionInLine = studentLinePosition - 1
//                   return
//               }
//           }
//
//       } catch {
//           print("error: \(error)")
//       }
//   }
//
//
//
//    func addListnerToLine(joinCode: String) async throws {
//        guard let currentUser = self.userSession?.uid else {
//            print("user does not exist")
//            return
//        }
//        do {
//            // Retrieve the instructor document with the same join code.
//            let professorQuerySnapshot = try await db.collection("users").whereField("joincode", isEqualTo: joinCode).getDocuments()
//
//            // Users -> UID -> Students
//            // Fetches the instructor with the corresponding join code.
//            guard let professorDocument = professorQuerySnapshot.documents.first else {
//                print("Professor not found")
//                return
//            }
//
//            // Retrieve the ID of the instructor document
//            let professorID = professorDocument.documentID
//            let officehoursCollection = db.collection("users").document(professorID).collection("Office Hours").order(by: "linePosition")
//
//            officehoursCollection.addSnapshotListener(includeMetadataChanges: true) { querySnapshot, error in
//                //Check if there are documents (aka "students") in the Office Hours collection.
//                guard let documents = querySnapshot?.documents else {
//                    print("No students in Office Hours.")
//                    return
//                }
//
//                if let querySnapshot = querySnapshot {
//
//                    querySnapshot.documentChanges.forEach { diff in
//                        if diff.type == .modified {
//                            var student = diff.document.data()
//                            self.positionInLine = student["linePosition"] as? Int ?? 0
//                        }
//
//                    }
//                }
//            }
//
//        }
//    }
//
//
//
//    func setupStudentsListListener() async throws{
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        // Reference to the "Office Hours" collection
//        let officeHoursCollectionRef = db.collection("users").document(uid).collection("Office Hours")
//
//        // Setup snapshot listener
//        officeHoursCollectionRef.addSnapshotListener { snapshot, error in
//            guard let snapshot = snapshot else {
//                print("Error fetching students")
//                return
//            }
//
//            var studentsList: [(uid: String, fullname: String)] = []
//
//            // Sort documents based on their positionNumber attribute
//            let sortedDocuments = snapshot.documents.sorted { (doc1, doc2) -> Bool in
//                guard let position1 = doc1["linePosition"] as? Int,
//                      let position2 = doc2["linePosition"] as? Int else {
//                    return false // If positionNumber attribute is missing in any document, don't change order
//                }
//                return position1 < position2
//            }
//
//            for document in sortedDocuments {
//                if let uid = document["id"] as? String,
//                   let fullname = document["fullname"] as? String{
//                    studentsList.append((uid: uid, fullname: fullname))
//                }
//            }
//            // Update the local array with the new data
//            self.allStudentsinoh = studentsList
//
//        }
//    }
//
//
//
//    func removeStudentFromLineInstructor(joinCode: String, UID: String) async throws {
//         var currentLinePosition = 0;
//
//       do {
//           // Retrieve the instructor document with the same join code.
//           let professorQuerySnapshot = try await Firestore.firestore().collection("users").whereField("joincode", isEqualTo: joinCode).getDocuments()
//
//           // Users -> UID -> Students
//           // Fetches the instructor with the corresponding join code.
//           guard let professorDocument = professorQuerySnapshot.documents.first else {
//               print("Professor not found")
//               return
//           }
//
//           // Retrieve the ID of the instructor document
//           let professorID = professorDocument.documentID
//           let officehoursCollection = db.collection("users").document(professorID).collection("Office Hours")
//
//           // Get the reference to the student's document in the "Office Hours" collection
//           let studentDocumentReference = officehoursCollection.document(UID)
//
//           do {
//               //get all the documents with userID in office hours
//               let studentQuerySnapshot = try await officehoursCollection.whereField("id", isEqualTo: studentDocumentReference.documentID).getDocuments()
//
//
//               //Removing the student
//               for document in studentQuerySnapshot.documents {
//                   var studentData = document.data()
//                   //get the removed student's position in line.
//                   if let linePosition = studentData["linePosition"] as? Int {
//                       currentLinePosition = linePosition
//                   }
//                   try await document.reference.delete()
//                   print("Document \(document.documentID) deleted successfully.")
//               }
//           } catch {
//               print("Error deleting documents: \(error)")
//           }
//
//            //Get all of the students in the instructor's course.
//           let studentsInOfficeHours = try await officehoursCollection.order(by: "entryDate").getDocuments()
//
//           for student in studentsInOfficeHours.documents {
//               var studentData = student.data()
//
//               guard let studentLinePosition = studentData["linePosition"] as? Int else {
//                   print("could not find the line position...")
//                   return
//               }
//
//               if studentLinePosition > currentLinePosition {
//                   try await student.reference.updateData(["linePosition" : (studentLinePosition - 1)])
//                   print("Updated position for student \(student.documentID) to \(studentLinePosition - 1)")
//
//               }
//           }
//
//       } catch {
//           print("error: \(error)")
//       }
//   }
//
//
//
//
//    func endOh(joinCode: String) async throws {
//
//         var currentLinePosition = 0;
//
//       do {
//           // Retrieve the instructor document with the same join code.
//           let professorQuerySnapshot = try await Firestore.firestore().collection("users").whereField("joincode", isEqualTo: joinCode).getDocuments()
//
//           // Users -> UID -> Students
//           // Fetches the instructor with the corresponding join code.
//           guard let professorDocument = professorQuerySnapshot.documents.first else {
//               print("Professor not found")
//               return
//           }
//
//           // Retrieve the ID of the instructor document
//           let professorID = professorDocument.documentID
//           let officehoursCollection = db.collection("users").document(professorID).collection("Office Hours")
//
//           // Get the reference to the student's document in the "Office Hours" collection
//           //let studentDocumentReference = officehoursCollection.document(UID)
//
//           let studentDocumentReference = try await officehoursCollection.getDocuments()
//
//           do {
//
//
//               //Removing the student
//               for document in studentDocumentReference.documents {
//                   var studentData = document.data()
//                   //get the removed student's position in line.
//                   if let linePosition = studentData["linePosition"] as? Int {
//                       currentLinePosition = linePosition
//                   }
//                   try await document.reference.delete()
//                   print("Document \(document.documentID) deleted successfully.")
//               }
//           } catch {
//               print("Error deleting documents: \(error)")
//           }
//
//            //Get all of the students in the instructor's course.
//           let studentsInOfficeHours = try await officehoursCollection.order(by: "entryDate").getDocuments()
//
//           for student in studentsInOfficeHours.documents {
//               var studentData = student.data()
//
//               guard let studentLinePosition = studentData["linePosition"] as? Int else {
//                   print("could not find the line position...")
//                   return
//               }
//
//               if studentLinePosition > currentLinePosition {
//                   try await student.reference.updateData(["linePosition" : (studentLinePosition - 1)])
//                   print("Updated position for student \(student.documentID) to \(studentLinePosition - 1)")
//
//               }
//           }
//
//       } catch {
//           print("error: \(error)")
//       }
//   }
}//end of class



