try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

import pyext

setup(name='pyext',
      version=str(pyext.__version__),
      author='Ryan Gonzalez',
      author_email='kirbyfan64sos@gmail.com',
      py_modules=['pyext'],
      description='Simple Python extensions.',
      long_description="",
      classifiers=[
          'License :: OSI Approved :: MIT License',
          'Programming Language :: Python :: 2',
          'Programming Language :: Python :: 3']
      )
