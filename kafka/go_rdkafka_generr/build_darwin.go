// +build darwin

package kafka

// #cgo CFLAGS: -I${SRCDIR}/../../../../../../3rdparty/include
// #cgo LDFLAGS: ${SRCDIR}/../../../../../../3rdparty/lib/darwin_amd64/librdkafka.a ${SRCDIR}/../../../../../../3rdparty/lib/darwin_amd64/liblz4.a -lcrypto -lssl -lz -lm -lsasl2 -ldl
//
import "C"
