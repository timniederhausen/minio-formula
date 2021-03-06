# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config' %}
{%- from tplroot ~ "/map.jinja" import minio with context %}

include:
  - {{ sls_config_file }}

minio-service-running-service-running:
  service.running:
    - name: {{ minio.service.name }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
