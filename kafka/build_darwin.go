// +build darwin

package kafka

// #cgo CFLAGS: -I${SRCDIR}/../../../../../3rdparty/include
// #cgo LDFLAGS: ${SRCDIR}/../../../../../3rdparty/lib/darwin_amd64/librdkafka.a ${SRCDIR}/../../../../../3rdparty/lib/darwin_amd64/liblz4.a ${SRCDIR}/../../../../../3rdparty/lib/darwin_amd64/libsasl2.a ${SRCDIR}/../../../../../3rdparty/lib/darwin_amd64/libcrypto.a ${SRCDIR}/../../../../../3rdparty/lib/darwin_amd64/libssl.a -lz -lm -ldl
//
import "C"
