from flask import Flask, request, jsonify


app = Flask(__name__)

@app.route('/api', methods = ['GET'])
def returnascii():
    d = {}
    input_chr = str(request.args['query'])
    answer = str(ord(input_chr))
    d['output'] = answer
    return jsonify(d)

if __name__ =="__main__":
    app.run(host="0.0.0.0",port=5000)
