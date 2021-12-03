import sys
from os.path import exists
import re
from authlib.jose import JsonWebKey

def read_file(filename):
  fh = open(filename, "r")
  try:
      return fh.read()
  finally:
      fh.close()

def jwk_from_pem(pem, jwks):
    key = JsonWebKey.import_key(pem, {'kty': 'RSA'})
    if jwks != None :
        try:
            jwks.find_by_kid(key.thumbprint())
            return None
        except ValueError as ve:
            None # kid not exists: do nothing
    return """
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
		}}""".format(
            inline_cert=pem.replace("\n","").replace("-----BEGIN CERTIFICATE-----", "").replace("-----END CERTIFICATE-----",""),
            thumbprint=key.thumbprint(),
            modulus=key.as_dict()['n'],
            exponent=key.as_dict()['e']
        )

old_jwks = None
keys = []
if exists(sys.argv[1]) :
    old_jwks_data = read_file(sys.argv[1])
    if old_jwks_data != "" :
        old_jwks = JsonWebKey.import_key_set(old_jwks_data.strip())
        keys.append(re.sub("\s*]\s*}\s*$", "", re.sub('^\s*\{\s*"keys"\s*:\s*\[\s*', "\n		", old_jwks_data)))

for i in range(2, len(sys.argv)):
    pem = sys.argv[i]
    jwk = jwk_from_pem(pem, old_jwks)
    if jwk is not None:
        keys.append(jwk)

sys.stdout.write("""{{
	"keys": [{}
	]
}}""".format(','.join(keys))
)