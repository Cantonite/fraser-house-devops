import os
import qrcode

url = os.getenv("URL")

print(f"Generating QR code for: '{url}'")

qr = qrcode.QRCode(version=1, box_size=10, border=5)
qr.add_data(url)
qr.make(fit=True)
img = qr.make_image(fill='black', back_color='white')
img.save('.output/dev.png')
