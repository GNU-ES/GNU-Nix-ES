import numpy as np
from numpy import array, int32

import primes



print(primes.__doc__)

print(primes.logical_to_integer.__doc__)

sieve_array = primes.sieve(100)

# https://numpy.org/doc/stable/reference/generated/numpy.testing.assert_array_equal.html
prime_numbers = primes.logical_to_integer(sieve_array, sum(sieve_array))

print(prime_numbers)

# assert str(prime_numbers) == '[ 2  3  5  7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97]'

expected = array([ 2,  3,  5,  7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97], dtype=int32)

np.testing.assert_array_equal(expected, prime_numbers)

