import os
import qrcode

function_url = os.getenv("FUNCTION_URL")

print(f"Generating QR code for: '{function_url}'")

qr = qrcode.QRCode(version=1, box_size=10, border=5)
qr.add_data(function_url)
qr.make(fit=True)
img = qr.make_image(fill='black', back_color='white')
img.save('dev.png')
