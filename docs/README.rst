.. _readme:

minio-formula
================

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/timniederhausen/minio-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/timniederhausen/minio-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula that installs and manages a basic MinIO configuration.

Currently only FreeBSD is supported!

.. contents:: **Table of Contents**
   :depth: 1

Available states
----------------

.. contents::
   :local:

``minio``
^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs the minio package,
manages the minio configuration file and then
starts the associated minio service.

``minio.package``
^^^^^^^^^^^^^^^^^^^^

This state will install the minio package only.

``minio.config``
^^^^^^^^^^^^^^^^^^^

This state will configure the minio service and has a dependency on ``minio.install``
via include list.

``minio.service``
^^^^^^^^^^^^^^^^^^^^

This state will start the minio service and has a dependency on ``minio.config``
via include list.

``minio.clean``
^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``minio`` meta-state in reverse order, i.e.
stops the service,
removes the configuration file and
then uninstalls the package.

``minio.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will stop the minio service and disable it at boot time.

``minio.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of the minio service and has a
dependency on ``minio.service.clean`` via include list.

``minio.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the minio package and has a depency on
``minio.config.clean`` via include list.
