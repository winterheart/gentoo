# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )

#https://github.com/gnuradio/volk/issues/383
CMAKE_BUILD_TYPE="None"
inherit cmake python-single-r1

DESCRIPTION="vector optimized library of kernels"
HOMEPAGE="http://libvolk.org"
SRC_URI="https://github.com/gnuradio/volk/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64 ~arm ~riscv ~x86"
IUSE="orc test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	net-wireless/gnuradio
	dev-libs/boost:=
	orc? ( dev-lang/orc )"
DEPEND="${RDEPEND}
	$(python_gen_cond_dep 'dev-python/mako[${PYTHON_USEDEP}]')"

RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		-DENABLE_ORC=$(usex orc)
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DENABLE_TESTING="$(usex test)"
		-DENABLE_PROFILING=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# Remove stray python files generated by the build system
	find "${ED}" -name '*.pyc' -exec rm -f {} \; || die
	find "${ED}" -name '*.pyo' -exec rm -f {} \; || die
	python_optimize
}
