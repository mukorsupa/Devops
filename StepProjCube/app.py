from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

# Connect to MySQL
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="password",
        database="yourdb"
    )

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/users', methods=['GET'])
def get_users():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users")
    users = cursor.fetchall()
    conn.close()
    return jsonify(users)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
