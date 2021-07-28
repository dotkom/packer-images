Needs a file injected at runtime to fuction

A file containing json data at /etc/consul.d/runtime-config-vars
example data:
```
{
    "datacenter": "xyz",
    "primary_datacenter: "xyzw",
    "bootstrap_expect: 3,
    "acl_role": "consul-node",
    "retry_join": ["192.168.1.1"],
    "retry_join_wan": ["provider=azure tag_name=consul-auto-join tag_value=true"]
}
```
