#!/usr/bin/python
# not compatible with python 3
__author__      = "Sander Granneman"
__copyright__   = "Copyright 2017"
__version__     = "1.2.4.0"
__credits__     = ["Sander Granneman","Hywell Dunn Davies"]
__maintainer__  = ["Rob van Nues, via SlackBuilds.org"]
__email__       = "sgrannem@staffmail.ed.ac.uk"
__status__      = "Production"

import sys
import os
import platform
import setuptools
from setuptools import setup

DEFAULT_PATH = "/usr/share/"

if sys.version[0:3] < '2.7' : raise ImportError('Python version 2.7 or above is required for pyCRAC')
if sys.version[0:3] >= '3.0': raise ImportError('pyCRAC is not compatible with Python 3.0 or higher')

sys.stdout.write("\nInstalling pyCRAC version %s...\n" % __version__)

path_files = open("pyCRAC/defaults.py","w")
#path_files.write("DEFAULT_PATH=\"%s\"\n" % DEFAULT_PATH)
path_files.write("GTF=\"%spyCRAC-%s/db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf\"\nTAB=\"%spyCRAC-%s/db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab\"\nCHROM=\"%spyCRAC-%s/db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt\"\n" % (DEFAULT_PATH,__version__,DEFAULT_PATH,__version__,DEFAULT_PATH,__version__))
path_files.close()

setup(name='pyCRAC',
	version='%s' % __version__,
	description='Python NextGen sequencing data processing software',
	author='Sander Granneman',
	author_email='sgrannem@staffmail.ed.ac.uk',
	url='http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html',
	packages=['pyCRAC','pyCRAC.Parsers','pyCRAC.Classes','pyCRAC.Methods'],
	install_requires=['numpy >= 1.5.1', 'cython >=0.19', 'pysam >= 0.6'],
	scripts=[
					'pyCRAC/pyReadAligner.py',
					'pyCRAC/pyMotif.py',
					'pyCRAC/pyPileup.py',
					'pyCRAC/pyBarcodeFilter.py',
					'pyCRAC/pyReadCounters.py',
					'pyCRAC/pyBinCollector.py',
					'pyCRAC/pyCalculateFDRs.py',
					'pyCRAC/pyClusterReads.py',
					'pyCRAC/pyCalculateMutationFrequencies.py',
					'pyCRAC/scripts/pyCalculateChromosomeLengths.py',
					'pyCRAC/scripts/pyFastqDuplicateRemover.py',
					'pyCRAC/scripts/pyAlignment2Tab.py',
					'pyCRAC/scripts/pyGetGTFSources.py',
					'pyCRAC/scripts/pySelectMotifsFromGTF.py',
					'pyCRAC/scripts/pyFasta2tab.py',
					'pyCRAC/scripts/pyFastqJoiner.py',
					'pyCRAC/scripts/pyFastqSplitter.py',
					'pyCRAC/scripts/pyExtractLinesFromGTF.py',
					'pyCRAC/scripts/pyGetGeneNamesFromGTF.py',
					'pyCRAC/scripts/pyCheckGTFfile.py',
					'pyCRAC/scripts/pybed2GTF.py',
					'pyCRAC/scripts/pyGTF2sgr.py',
					'pyCRAC/scripts/pyGTF2bed.py',
					'pyCRAC/scripts/pyGTF2bedGraph.py',
					'pyCRAC/scripts/pyFilterGTF.py',
					'pyCRAC/scripts/pyNormalizeIntervalLengths.py',
					'pyCRAC/kinetic_crac_pipeline/CRAC_pipeline_PE.py',
					'pyCRAC/kinetic_crac_pipeline/CRAC_pipeline_PeakFinder.py',
					'pyCRAC/kinetic_crac_pipeline/CRAC_pipeline_SE.py',
					'pyCRAC/kinetic_crac_pipeline/TrimNucs.py'
				],
	classifiers=[   'Development Status :: 5 - Production/Stable',
					'Environment :: Terminal',
					'Intended Audience :: Education',
					'Intended Audience :: Developers',
					'Intended Audience :: Science/Research',
					'License :: Freeware',
					'Operating System :: MacOS :: MacOS X',
					'Operating System :: POSIX',
					'Programming Language :: Python :: 2.7',
					'Topic :: Scientific/Engineering :: Bio-Informatics',
					'Topic :: Software Development :: Libraries :: Application Frameworks'
				],
	data_files=[    ('%spyCRAC-%s/db/' % (DEFAULT_PATH,__version__), [
					'pyCRAC/db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt',
					'pyCRAC/db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf',
					'pyCRAC/db/Saccharomyces_cerevisiae.EF2.59.1.0.fa',
					'pyCRAC/db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab']),
					('%spyCRAC-%s/tests/' % (DEFAULT_PATH,__version__), [
					'tests/test.novo',
					'tests/test.sh',
					'tests/test_coordinates.txt',
					'tests/test.gtf',
					'tests/test_f.fastq',
					'tests/test_f.fastq.gz',
					'tests/test_f_dm.fastq',
					'tests/test_r.fastq',
					'tests/test_r.fastq.gz',
					'tests/test_r_dm.fastq',
					'tests/indexes.txt',
					'tests/barcodes.txt',
					'tests/genes.list'])
				]
			  )



