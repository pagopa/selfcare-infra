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

sys.stdout.write(key.as_dict()['n'])
sys.stdout.write('\n')
sys.stdout.write(key.as_dict()['e'])