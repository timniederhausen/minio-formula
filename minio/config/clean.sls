# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import minio with context %}

include:
  - {{ sls_service_clean }}

{% if grains.os_family == 'FreeBSD' %}
{%  for name in ['user', 'group', 'address', 'logfile', 'certs', 'disks'] %}
minio-config-clean-{{ name }}:
  sysrc.absent:
    - name: minio_{{ name }}
{%  endfor %}
{% endif %}
