Needs a file injected at runtime to fuction

A file containing json data at /etc/nomad.d/runtime-config-vars
example data:
```
{
    "datacenter": "xyz",
    "bootstrap_expect: 3,
    "node_name": "node 1",
}