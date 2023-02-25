# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="doit tasks for python stuff"
HOMEPAGE="https://pythonhosted.org/doit-py/ https://github.com/pydoit/doit-py"
SRC_URI="https://github.com/pydoit/doit-py/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~riscv ~x86"

DEPEND="
	test? (
		app-text/hunspell[l10n_en]
		dev-python/pyflakes[${PYTHON_USEDEP}]
	)"
RDEPEND="
	dev-python/configclass[${PYTHON_USEDEP}]"

distutils_enable_sphinx doc
distutils_enable_tests pytest
