"""Geneartes a QR code for the URL set in the URL environment variable"""

import os
import qrcode

url = os.getenv("URL")
env_name = os.getenv("ENV_NAME")

print(f"Generating QR code for: '{url}'")

qr = qrcode.QRCode(version=1, box_size=10, border=5)
qr.add_data(url)
qr.make(fit=True)
img = qr.make_image(fill='black', back_color='white')
img.save(f".output/{env_name}.png")
