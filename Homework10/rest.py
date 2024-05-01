from flask import Flask, request, jsonify

app = Flask(__name__)


# Function to read student data from CSV file
def read_students():
    students = []
    try:
        with open("students.csv", "r") as file:
            for line in file:
                id, first_name, last_name, age = line.strip().split(",")
                students.append({
                    "id": id,
                    "first_name": first_name,
                    "last_name": last_name,
                    "age": age
                })
    except FileNotFoundError:
        # Create an empty CSV file if it doesn't exist
        open("students.csv", "w").close()
    return students


# Function to write student data to CSV file
def write_students(students):
    with open("students.csv", "w") as file:
        for student in students:
            file.write(f"{student['id']},{student['first_name']},{student['last_name']},{student['age']}\n")


# Function to generate a new student ID
def get_next_id(students):
    if not students:
        return 1
    return int(students[-1]["id"]) + 1


# GET /students - Retrieve all students
@app.route("/students", methods=["GET"])
def get_all_students():
    students = read_students()
    return jsonify(students)


# GET /students/<id> - Retrieve student by ID
@app.route("/students/<int:id>", methods=["GET"])
def get_student_by_id(id):
    students = read_students()
    for student in students:
        if student["id"] == str(id):
            return jsonify(student)
    return jsonify({"error": "Student not found"}), 404


# GET /students/last_name/<last_name> - Retrieve students by last name
@app.route("/students/last_name/<string:last_name>", methods=["GET"])
def get_students_by_last_name(last_name):
    students = read_students()
    found_students = [student for student in students if student["last_name"] == last_name]
    if found_students:
        return jsonify(found_students)
    return jsonify({"error": "Student not found"}), 404


# POST /students - Create a new student
@app.route("/students", methods=["POST"])
def create_student():
    data = request.get_json()
    if not data or not all(field in data for field in ["first_name", "last_name", "age"]):
        return jsonify({"error": "Missing required fields"}), 400
    students = read_students()
    new_student = {
        "id": str(get_next_id(students)),
        "first_name": data["first_name"],
        "last_name": data["last_name"],
        "age": data["age"]
    }
    students.append(new_student)
    write_students(students)
    return jsonify(new_student)


# PUT /students/<id> - Update student by ID
@app.route("/students/<int:id>", methods=["PUT"])
def update_student(id):
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing update data"}), 400
    students = read_students()
    found = False
    for i, student in enumerate(students):
        if student["id"] == str(id):
            student.update(data)
            found = True
            break
    if not found:
        return jsonify({"error": "Student not found"}), 404
    write_students(students)
    return jsonify(students[i])


# PATCH /students/<id> - Update student's age by ID
@app.route("/students/<int:id>", methods=["PATCH"])
def update_student_age(id):
    data = request.get_json()
    if not data or not "age" in data:
        return jsonify({"error": "Missing age field"}), 400
    students = read_students()
    found = False
    for i, student in enumerate(students):
        if student["id"] == str(id):
            student["age"] = data["age"]
            found = True
            break
    if not found:
        return jsonify({"error": "Student not found"}), 404
    write_students(students)
    return jsonify(student)


# DELETE /students/<id> - Delete student by ID
@app.route("/students/<int:id>", methods=["DELETE"])
def delete_student(id):
    students = read_students()
    found = False
    new_students = [student for student in students if student["id"] != str(id)]
    if len(new_students) != len(students):
        found = True
        students = new_students
    if not found:
        return jsonify({"error": "Student not found"}), 404
    write_students(students)
    return jsonify({"message": "Student deleted successfully"})


if __name__ == "__main__":
    app.run(debug=True)
