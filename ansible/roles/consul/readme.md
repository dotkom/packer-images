Some runtime information has to be injected. This can be done with cloud init and user data.
The servers need the condfig in either .hcl or .json and has to b after "00-consul.hcl" ordered alphabetically
to properly merge.

Clients need "datacenter", "primary_datacenter", "retry_join", "encrypt" and "acl.tokens.default". 
The servers will in addition need "bootstrap_expect" and "retry_join_wan"