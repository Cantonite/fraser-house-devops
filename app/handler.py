"""Returns an emoji which is set as an environment variable"""

import os
import json

emoji = os.getenv("EMOJI")

def handler(_event, _context):
    """Handles the web request and returns the emoji in JSON"""
    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Headers" : "Content-Type",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "OPTIONS,GET"
        },
        "body": json.dumps({"emoji": emoji}),
    }
