from flask import Flask
from flask import request
import tiles_and_coordinates
import json
import image_worker
app = Flask(__name__)


@app.route("/", methods=["GET"])
def hello():
    lats = json.loads(request.args.get("lat"))
    longs = json.loads(request.args.get("lon"))
    detalisation = float(request.args.get("detalisation"))
    tilesList =  tiles_and_coordinates.make_tiles_list(lats, longs)
    print tilesList
    for image in tilesList:
        image_worker.create_image(image, detalisation)

    return ""

if __name__ == "__main__":
    app.run(host="0.0.0.0")
