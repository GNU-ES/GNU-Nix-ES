import re


string = '&& git checkout 2192bf9fd983b70a692be0541ddc3f583e327a72 \\'

print(re.sub(r'(?<=^&& git checkout \b).*(?=\b)', 'Some thing.', string))


