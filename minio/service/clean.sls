# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import minio with context %}

minio-service-clean-service-dead:
  service.dead:
    - name: {{ minio.service.name }}
    - enable: False
