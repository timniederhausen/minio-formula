# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import minio with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

{% if grains.os_family == 'FreeBSD' %}
{% set mapping = {'address': 'listen_address'} %}
{# Defaults from /usr/local/etc/rc.d/minio #}
{% set defaults = {
  'user': 'minio',
  'group': 'minio',
  'address': ':9000',
  'logfile': '/var/log/minio.log',
  'certs': '/var/tmp/minio',
} %}
{%  for name, def in defaults.items() %}
{%   if minio.get(mapping.get(name, name), def) != def %}
minio-config-{{ name }}:
  sysrc.managed:
    - name: minio_{{ name }}
    - value: {{ minio[mapping.get(name, name)] | yaml(False) }}
{%   endif %}
{%  endfor %}

minio-config-disks:
  sysrc.managed:
    - name: minio_disks
    - value: "{{ minio.disks | join(' ') }}"
{% endif %}
