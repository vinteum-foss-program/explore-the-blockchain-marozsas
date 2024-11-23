# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`

xpubkey='xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2'
descriptor="tr(${xpubkey}/0/*)"
checksum=$(bitcoin-cli getdescriptorinfo $descriptor | jq -r '.checksum')
bitcoin-cli deriveaddresses "${descriptor}#${checksum}" "[100,100]" | jq -r '.[]'

# alternate solution
# descriptor="tr(${xpubkey}/0/100)"
# checksum=$(bitcoin-cli getdescriptorinfo $descriptor | jq -r '.checksum')
# bitcoin-cli deriveaddresses "${descriptor}#${checksum}"| jq -r '.[]'
