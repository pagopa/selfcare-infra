import sys
from authlib.jose import JsonWebKey

def read_file(filename):
  fh = open(filename, "r")
  try:
      return fh.read()
  finally:
      fh.close()

# key_data = read_file(sys.argv[1])
key_data = sys.argv[1]
key = JsonWebKey.import_key(key_data, {'kty': 'RSA'})

sys.stdout.write("""{{
    "keys": [
     {{
         "alg": "RS256",
         "kty": "RSA",
         "use": "sig",
         "x5c": [
             "{inline_cert}"
         ],
         "n": "{modulus}",
         "e": "{exponent}",
         "kid": "{thumbprint}",
         "x5t": "{thumbprint}"
     }}
   ]
}}""".format(
    inline_cert=key.sys.argv[1].replace("\n","").replace("-----BEGIN CERTIFICATE-----", "").replace("-----END CERTIFICATE-----",""),
    thumbprint=key.thumbprint(),
    modulus=key.as_dict()['n'],
    exponent=key.as_dict()['e']
))