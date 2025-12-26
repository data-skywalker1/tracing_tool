# from random import randint
# from flask import Flask, request
# import logging
# import os

# app = Flask(__name__)
# logging.basicConfig(level=logging.INFO)
# logger = logging.getLogger(__name__)

# # os.environ["OTEL_PYTHON_LOGGING_AUTO_INSTRUMENTATION_ENABLED"] = "true"

# @app.route("/rolldice")
# def roll_dice():
#     player = request.args.get('player', default=None, type=str)
#     result = str(roll())
#     if player:
#         logger.warning("%s is rolling the dice: %s", player, result)
#     else:
#         logger.warning("Anonymous player is rolling the dice: %s", result)
#     return result


# def roll():
#     return randint(1, 6)


# # if __name__ == '__main__':
# #     app.run(debug=True)