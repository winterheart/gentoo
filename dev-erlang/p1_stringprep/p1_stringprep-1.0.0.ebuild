# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib

MY_PN="stringprep"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fast Stringprep implementation for Erlang / Elixir"
HOMEPAGE="https://github.com/processone/stringprep"
SRC_URI="https://github.com/processone/${MY_PN}/archive/${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND=">=dev-erlang/p1_utils-1.0.1
	>=dev-lang/erlang-17.1"
DEPEND="${CDEPEND}
	dev-util/rebar"
RDEPEND="${CDEPEND}"

DOCS=( README.md )

S="${WORKDIR}/${MY_P}"

get_erl_libs() {
	echo "/usr/$(get_libdir)/erlang/lib"
}

src_prepare() {
	# Suppress deps check.
	cat<<EOF >>"${S}/rebar.config.script"
lists:keystore(deps, 1, CONFIG, {deps, []}).
EOF
}

src_configure() {
	export ERL_LIBS="${EPREFIX}$(get_erl_libs)"
	econf --libdir="${ERL_LIBS}"
}

src_compile() {
	export ERL_LIBS="${EPREFIX}$(get_erl_libs)"
	rebar compile || die 'rebar compile failed'
}

src_install() {
	insinto "$(get_erl_libs)/${P}"
	doins -r ebin priv src
	dodoc "${DOCS[@]}"
}
