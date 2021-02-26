#!/usr/bin/python

__author__      = "Sander Granneman"
__copyright__   = "Copyright 2020"
__version__     = "1.5.0"
__credits__     = ["Sander Granneman","Grzegorz Kudla","Hywell Dunn Davies"]
__maintainer__  = ["Sander Granneman","Rob van Nues via SlackBuilds.org"]
__email__       = ["sgrannem@staffmail.ed.ac.uk", "sborg63@disroot.org"]
__status__      = "Production"

import sys
import os
import platform
import setuptools
from setuptools import setup
from setuptools.command import easy_install

DEFAULT_PATH = "/usr/share/"

sys.stdout.write("\nInstalling pyCRAC version %s...\n" % __version__)


setup(name='pyCRAC',
	version='%s' % __version__,
	description='Python NextGen sequencing data processing software',
	author='Sander Granneman',
	author_email='sgrannem@staffmail.ed.ac.uk',
	url='http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html',
	packages=['pyCRAC','pyCRAC.Parsers','pyCRAC.Classes','pyCRAC.Methods'],
	install_requires=['numpy >= 1.5.1', 'cython >=0.19', 'pysam >= 0.6','six >= 1.9.0'],
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
					'pyCRAC/crac_pipelines/CRAC_pipeline_PE.py',
					'pyCRAC/crac_pipelines/CRAC_pipeline_SE.py',
				],
	classifiers=[   'Development Status :: 5 - Production/Stable',
					'Environment :: Console',
					'Intended Audience :: Education',
					'Intended Audience :: Developers',
					'Intended Audience :: Science/Research',
					'License :: Freeware',
					'Operating System :: MacOS :: MacOS X',
					'Operating System :: POSIX',
					'Programming Language :: Python :: 3.6',
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
