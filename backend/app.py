from flask import Flask, request, jsonify
from db import get_db_connection

app = Flask(__name__)

@app.route('/appointments', methods=['GET'])
def get_appointments():
    user_id = request.args.get('user_id')  
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("SELECT role FROM users WHERE user_id = %s;", (user_id,))
    role = cur.fetchone()[0]

    if role == "patient":
        cur.execute("SELECT * FROM appointments WHERE patient_id = %s;", (user_id,))
    elif role == "doctor":
        cur.execute("SELECT * FROM appointments WHERE doctor_id = %s;", (user_id,))
    elif role == "nurse":
        cur.execute("SELECT * FROM appointments;")
    else:
        return jsonify({"error": "Unauthorized"}), 403

    data = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True)
