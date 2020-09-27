# Source
# https://stackoverflow.com/a/49060084


. ./args-wrapper.sh

# then you could simply use the variables like so:
echo 'Arguments values starting with -'
echo "$a_variable";
echo "$abcdfg_variable";
echo "$abcdfg_123_42_variable";

echo 'Arguments values starting with --'
# Not allowed, dont know why.
#echo "$b_variable";
echo "$bc_variable";
echo "$bcd_variable";
echo "$bcdefg_variable";
echo "$bcdefg_123_42_variable";


