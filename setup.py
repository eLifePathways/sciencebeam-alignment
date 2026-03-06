from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy as np

ext_modules = cythonize([
    Extension(
        "sciencebeam_alignment.align_fast_utils",
        sources=["sciencebeam_alignment/align_fast_utils.pyx"],
        include_dirs=[np.get_include()],
    )
])

setup(ext_modules=ext_modules)
