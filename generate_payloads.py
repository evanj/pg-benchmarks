#!/usr/bin/env python3

import string
import random
import json


# 10 pairs: 48 multiplier: 1941 string bytes; 2008 hstore bytes; 2032 row bytes
#     adding 1 byte to a value: 1942 string bytes; 2005 hstore bytes (external toast); 2033 row bytes
# 10 pairs: 49 multiplier: 1981 string bytes; 2044 hstore bytes; compressed to 199; 2072 row bytes
d = {}
for i in range(10):
  k = 'k{}'.format(i) * 49
  v = 'v{}'.format(i) * 49
  d[k] = v
  print('{}=>{},'.format(k, v), end='')

print(json.dumps(d, separators=(',', ':')))



# the uncompressed version has kv_len=96
letters_digits = string.ascii_letters + string.digits
kv_len = 97
num_keys = 10
for i in range(num_keys):
  k = ''.join(random.choices(letters_digits, k=kv_len))
  v = ''.join(random.choices(letters_digits, k=kv_len))
  print('{}=>{},'.format(k, v), end='')

print('text uncompressed')
print(''.join(random.choices(letters_digits, k=2004)))


print('json')
d = {}
jsonb_d = {}
jsonb_compressed_d = {}
toast_compressed = {}
kv_len = 96  # 97 = 2005/2029; need to add 13 bytes to values for max len json
compressed_toast_v_len = 172
compressed_toast_non_random_values = 0
for i in range(num_keys):
  k_compressible = 'k{}'.format(i) * int(kv_len/2)
  k = ''.join(random.choices(letters_digits, k=kv_len))
  v = ''.join(random.choices(letters_digits, k=kv_len+2))
  d[k] = v
  jsonb_v = ''.join(random.choices(letters_digits, k=kv_len-1))
  jsonb_d[k[:kv_len-1]] = jsonb_v
  jsonb_compressed_d[k_compressible] = 'v{}'.format(i) * (int(kv_len/2) + 1)
  if i < compressed_toast_non_random_values:
    toast_compressed[k_compressible] = 'v{}'.format(i) * int(compressed_toast_v_len/2)
  else:
    toast_compressed[k_compressible] = ''.join(random.choices(letters_digits, k=compressed_toast_v_len))


print(json.dumps(d, separators=(',', ':')))
print(json.dumps(toast_compressed, separators=(',', ':')))
print(json.dumps(jsonb_d, separators=(',', ':')))
print(json.dumps(jsonb_compressed_d, separators=(',', ':')))
