import os

emoji = os.getenv("EMOJI")

def handler(event, context):
    return f"Hello, World! {emoji}"
