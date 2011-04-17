<tskel:before>
let b:uuid=tlib#string#Strip(system('uuidgen'))
</tskel:before>
<tskel:after>
unlet b:uuid
</tskel:after>
#ifndef <+FILE NAME ROOT:us/\W/_/+>_<+b:uuid:us/-/_/+>_<+FILE SUFFIX:u+>
#define <+FILE NAME ROOT:us/\W/_/+>_<+b:uuid:us/-/_/+>_<+FILE SUFFIX:u+>

<+CURSOR+>

#endif
