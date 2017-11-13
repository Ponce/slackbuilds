#from distutils.core import setup
from setuptools import setup

setup(
    name='responder',
    version='2.3.3.8',
    description='LLMNR/NBT-NS/mDNS Poisoner and NTLMv1/2 Relay',
    author='Laurent Gaffie',
    author_email='laurent.gaffie@gmail.com',
    license='GPLv3',
    url='https://github.com/lgandx/Responder/',
    long_description=open('README.md').read(),
    packages=['certs','files','logs','poisoners','servers','tools','tools.MultiRelay','tools.SMBFinger',],
)
