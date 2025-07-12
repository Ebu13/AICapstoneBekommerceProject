from flask import Flask, request, jsonify
from flask_cors import CORS
from chatbot import chat_with_user

app = Flask(__name__)
CORS(app)

@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    print("Gelen data:", data)  # Debug için
    user_input = data.get("message") or data.get("text")
    if not user_input:
        return jsonify({"error": "Boş mesaj gönderildi."}), 400
    response = chat_with_user(user_input)
    return jsonify({"response": response})

if __name__ == '__main__':
    # host=0.0.0.0 yaparak dışarıdan erişime açıyoruz
    app.run(host='0.0.0.0', debug=True)
