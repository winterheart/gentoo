# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake desktop

COMMIT="54f59df53d1f5a0a9a535be972bf23a6a95db8f5"
MY_PN="tsMuxer"

DESCRIPTION="Utility to create and demux TS and M2TS files"
HOMEPAGE="https://github.com/justdan96/tsMuxer"
SRC_URI="https://github.com/justdan96/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt5"

BDEPEND="virtual/pkgconfig"
DEPEND="qt5? (
		dev-qt/qtmultimedia:5
		dev-qt/qtwidgets:5
	)
	media-libs/freetype
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${COMMIT}"

DOCS=( README.md )

src_configure() {
	local mycmakeargs=(
		-DTSMUXER_GUI=$(usex qt5)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	if use qt5; then
		newbin "${BUILD_DIR}/${MY_PN}GUI/${MY_PN}GUI" "${PN}-gui"
		newicon "${MY_PN}GUI/images/icon.png" ${PN}.png
		make_desktop_entry "${PN}-gui" "${MY_PN}" ${PN}
	fi
}
