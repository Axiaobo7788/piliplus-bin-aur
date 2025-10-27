# Maintainer: yeah <yeah_yaojiu@163.com>

pkgname=piliplus-bin
pkgver=1.1.4.16
pkgrel=6
url="https://github.com/bggRGjQaUbCoE/PiliPlus"
pkgdesc="A Bilibili third-party client built with Flutter. | 使用Flutter开发的BiliBili第三方客户端"
arch=('x86_64' 'aarch64')
license=('GPL-3.0')
depends=('gtk3' 'mpv' 'libayatana-appindicator')
source_x86_64=("https://github.com/bggRGjQaUbCoE/PiliPlus/releases/download/1.1.4.16/PiliPlus_linux_1.1.4%2B4296_amd64.tar.gz")
source_aarch64=("https://github.com/bggRGjQaUbCoE/PiliPlus/releases/download/1.1.4.16/PiliPlus_linux_1.1.4%2B4296_arm64.tar.gz")
options=(!debug)

sha256sums_x86_64=("412d8d51f90796528a81a4b10da55dfe96b1a666427a6c2008893503193cc93d")
sha256sums_aarch64=("0c3b876186b848c34bc42a79bf967a1f061c6ebd40488d90aab2ab38e0723381")

package() {

  install -d "$pkgdir/opt/$pkgname"
  
  cp "$srcdir/piliplus" "$pkgdir/opt/$pkgname/"
  cp -r "$srcdir/lib" "$pkgdir/opt/$pkgname/"
  cp -r "$srcdir/data" "$pkgdir/opt/$pkgname/"


 install -Dm644 "$srcdir/data/flutter_assets/assets/images/logo/logo.png" \
    "$pkgdir/usr/share/icons/hicolor/256x256/apps/$pkgname.png"

  install -Dm644 /dev/stdin "$pkgdir/usr/share/applications/$pkgname.desktop" <<EOF
[Desktop Entry]
Name=PiliPlus
Version=1.1.4.16
Comment=A Bilibili third-party client built with Flutter.
Exec=piliplus
Icon=$pkgname
Terminal=false
Type=Application
Categories=Utility;
EOF

  install -d "$pkgdir/usr/bin"
  ln -s "/opt/$pkgname/piliplus" "$pkgdir/usr/bin/piliplus"
}