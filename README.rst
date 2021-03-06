Welcome to Read the Docs
========================

|build-status| |docs|

Purpose
-------

`Read the Docs`_ hosts documentation for the open source community. It supports
Sphinx_ docs written with reStructuredText_, and can pull from your Subversion_,
Bazaar_, Git_, and Mercurial_ repositories.
Then we build documentation and host it for you.
Think of it as *Continuous Documentation*.

.. _Read the docs: http://readthedocs.org/
.. _Sphinx: http://sphinx.pocoo.org/
.. _reStructuredText: http://sphinx.pocoo.org/rest.html
.. _Subversion: http://subversion.tigris.org/
.. _Bazaar: http://bazaar.canonical.com/
.. _Git: http://git-scm.com/
.. _Mercurial: https://www.mercurial-scm.org/

Documentation for RTD
---------------------

You will find complete documentation for setting up your project at `the Read
the Docs site`_.

.. _the Read the Docs site: https://docs.readthedocs.io/

Contributing
------------

You can find information about contributing to Read the Docs at our `Contribution page <http://docs.readthedocs.io/en/latest/contribute.html>`_.

Quickstart for GitHub-Hosted Projects
-------------------------------------

By the end of this quickstart, you will have a new project automatically updated
when you push to GitHub.

#. Create an account on `Read the Docs`_.  You will get an email verifying your
   email address which you should accept within 7 days.

#. Log in and click on "Import".

#. Give your project a name, add the HTTPS link for your GitHub project, and
   select Git as your repository type.

#. Fill in the rest of the form as needed and click "Create".

#. On GitHub, navigate to your repository and click on "Settings".

#. In the sidebar, click on "Web Hooks & Services", then find and click on the
   "ReadTheDocs" service.

#. Check the "Active" setting and click "Update Settings".

#. All done.  Commit away and your project will auto-update.


.. |build-status| image:: https://img.shields.io/travis/rtfd/readthedocs.org.svg?style=flat
    :alt: build status
    :scale: 100%
    :target: https://travis-ci.org/rtfd/readthedocs.org

.. |docs| image:: https://readthedocs.org/projects/docs/badge/?version=latest
    :alt: Documentation Status
    :scale: 100%
    :target: https://docs.readthedocs.io/en/latest/?badge=latest

License
-------

`MIT`_ © 2010-2017 Read the Docs, Inc & contributors

.. _MIT: LICENSE

Running locally with Minikube
-------

```
brew install kubectl
brew install minikube
```

Make sure you have some VM solution installed, like VirtualBox. Check if your current kubectl context is set to minikube:

```
minikube start
kubectl config current-context
minikube
```

Make sure it started on the dashboard with ```minikube dashboard```. Now we start the process of creating the image locally, telling kubectl to get the image from the local registry and apply the configs.
At the end the url for the external load balancer can be used to see the app.

```
docker build -t readthedocs .
eval $(minikube docker-env)
kubectl apply -f kubeconfigs/
minikube service readthedocs --url
```

or run

```
make local-deploy
```
