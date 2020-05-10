# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import minio with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

minio-config-file-file-managed:
  file.managed:
    - name: {{ minio.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='minio-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ minio.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        minio: {{ minio | json }}
