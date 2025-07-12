from flask import Flask, request, jsonify
from chatbot import chat_with_user

app = Flask(__name__)

@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    user_input = data.get("message")
    if not user_input:
        return jsonify({"error": "Boş mesaj."}), 400
    response = chat_with_user(user_input)
    return jsonify({"response": response})

if __name__ == '__main__':
    app.run(debug=True)
