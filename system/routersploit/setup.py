from setuptools import setup

setup(
    name='routersploit',
    version='2.2.1',
    author='Reverse Shell Security',
    packages=['routersploit','routersploit.modules','routersploit.templates','routersploit.test','routersploit.wordlists',],
    scripts=['rsf.py',],
    license='BSD-3-clause',
    long_description=open('README.md').read(),
    install_requires=['requests','paramiko','beautifulsoup4','pysnmp'],
)
