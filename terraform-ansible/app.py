from flask import Flask, request, abort

app = Flask(__name__)

@app.route('/hello')
def hello_prozorro():
    user_agent = request.headers.get('User-Agent')
    if user_agent == "bad guy":
        abort(403)  # Return 403
    return "hello prozorro"


if __name__ == '__main__':
    app.run(debug=True, port=8080)