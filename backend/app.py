from flask import Flask, request, jsonify, g
from db import get_db_connection
from functools import wraps

app = Flask(__name__)

# ✅ 1. Middleware to Get & Close DB Connection Per Request
@app.before_request
def before_request():
    """Opens a new database connection before handling a request."""
    g.db_conn = get_db_connection()
    g.cursor = g.db_conn.cursor()

@app.teardown_request
def teardown_request(exception):
    """Closes the database connection after handling a request."""
    cursor = getattr(g, 'cursor', None)
    if cursor:
        cursor.close()
    conn = getattr(g, 'db_conn', None)
    if conn:
        conn.close()

# ✅ 2. Role-Based Access Control (RBAC) Decorator
def require_role(allowed_roles):
    """Decorator to restrict access based on user role."""
    def decorator(f):
        @wraps(f)
        def wrapped(*args, **kwargs):
            user_id = request.args.get("user_id")
            if not user_id:
                return jsonify({"error": "Missing user_id"}), 400

            g.cursor.execute("SELECT role FROM users WHERE user_id = %s;", (user_id,))
            role = g.cursor.fetchone()

            if not role or role[0] not in allowed_roles:
                return jsonify({"error": "Unauthorized"}), 403
            
            return f(user_id, *args, **kwargs)
        return wrapped
    return decorator

# ✅ 3. Secure API Endpoint with RBAC Enforcement
@app.route("/appointments", methods=["GET"])
@require_role(["patient", "doctor", "nurse"])  # Enforce RBAC
def get_appointments(user_id):
    """Fetches appointments based on user role."""
    if request.method == "GET":
        if role := g.cursor.execute("SELECT role FROM users WHERE user_id = %s;", (user_id,)).fetchone()[0]:
            if role == "patient":
                g.cursor.execute("SELECT * FROM appointments WHERE patient_id = %s;", (user_id,))
            elif role == "doctor":
                g.cursor.execute("SELECT * FROM appointments WHERE doctor_id = %s;", (user_id,))
            elif role == "nurse":
                g.cursor.execute("SELECT * FROM appointments;")
            else:
                return jsonify({"error": "Unauthorized"}), 403

            return jsonify(g.cursor.fetchall())

    return jsonify({"error": "Invalid request"}), 400

if __name__ == "__main__":
    app.run(debug=True)
