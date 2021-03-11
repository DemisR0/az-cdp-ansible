#!/bin/sh
### DISABLE TRANSPARENT HUGEPAGES AT BOOT
## No parameter required
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled