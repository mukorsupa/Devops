import requests

# Base URL for the API endpoints
base_url = "http://localhost:5000"

# Function to write test results to a file
def write_results(text):
  with open("results.txt", "a") as file:
    file.write(text + "\n")


def main():
  # Retrieve all existing students (GET)
  response = requests.get(f"{base_url}/students")
  write_results(f"** GET /students (all students): **")
  write_results(response.text)
  print(f"GET /students (all students): {response.text}")

  # Create three students (POST)
  student1 = {"first_name": "John", "last_name": "Doe", "age": 25}
  student2 = {"first_name": "Jane", "last_name": "Smith", "age": 22}
  student3 = {"first_name": "Alice", "last_name": "Williams", "age": 30}
  for student in [student1, student2, student3]:
    response = requests.post(f"{base_url}/students", json=student)
    write_results(f"** POST /students (create student): **")
    write_results(response.text)
    print(f"POST /students (create student): {response.text}")

  # Retrieve information about all existing students (GET)
  response = requests.get(f"{base_url}/students")
  write_results(f"** GET /students (all students after creating 3): **")
  write_results(response.text)
  print(f"GET /students (all students after creating 3): {response.text}")

  # Update the age of the second student (PATCH)
  student_id = 2  # Assuming the second student's ID is 2
  update_data = {"age": 23}
  response = requests.patch(f"{base_url}/students/{student_id}", json=update_data)
  write_results(f"** PATCH /students/{student_id} (update age): **")
  write_results(response.text)
  print(f"PATCH /students/{student_id} (update age): {response.text}")

  # Retrieve information about the second student (GET)
  response = requests.get(f"{base_url}/students/{student_id}")
  write_results(f"** GET /students/{student_id} (after update): **")
  write_results(response.text)
  print(f"GET /students/{student_id} (after update): {response.text}")

  # Update the fist name, last name and the age of the third student (PUT)
  student_id = 3  # Assuming the third student's ID is 3
  update_data = {"first_name": "Alex", "last_name": "Thompson", "age": 31}
  response = requests.put(f"{base_url}/students/{student_id}", json=update_data)
  write_results(f"** PUT /students/{student_id} (update all): **")
  write_results(response.text)
  print(f"PUT /students/{student_id} (update all): {response.text}")

  # Retrieve information about the third student (GET)
  response = requests.get(f"{base_url}/students/{student_id}")
  write_results(f"** GET /students/{student_id} (after PUT): **")
  write_results(response.text)
  print(f"GET /students/{student_id} (after PUT): {response.text}")

  # Retrieve all existing students (GET)
  response = requests.get(f"{base_url}/students")
  write_results(f"** GET /students (all students after updates): **")
  write_results(response.text)
  print(f"GET /students (all students after updates): {response.text}")

   # Delete the first user (DELETE)
  student_id = 1  # Assuming the first student's ID is 1
  response = requests.delete(f"{base_url}/students/{student_id}")
  write_results(f"** DELETE /students/{student_id} (delete student): **")
  write_results(response.text)
  print(f"DELETE /students/{student_id} (delete student): {response.text}")

  # Retrieve all existing students (GET)
  response = requests.get(f"{base_url}/students")
  write_results(f"** GET /students (all students after deletion): **")
  write_results(response.text)
  print(f"GET /students (all students after deletion): {response.text}")


if __name__ == "__main__":
  main()