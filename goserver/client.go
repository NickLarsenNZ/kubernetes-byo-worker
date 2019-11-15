package main

import (
	"crypto/tls"
	"crypto/x509"
	"fmt"
	"io"
	"io/ioutil"
	"log"
)

func main() {
	cert, err := tls.LoadX509KeyPair("certs/client.pem", "certs/client.key")
	if err != nil {
		log.Fatalf("server: loadkeys: %s", err)
	}
	certpool := x509.NewCertPool()
	pem, err := ioutil.ReadFile("certs/ca.pem")
	if err != nil {
		log.Fatalf("Failed to read client certificate authority: %v", err)
	}
	if !certpool.AppendCertsFromPEM(pem) {
		log.Fatalf("Can't parse client certificate authority")
	}
	config := tls.Config{Certificates: []tls.Certificate{cert}, RootCAs: certpool}
	conn, err := tls.Dial("tcp", "localhost:8000", &config)
	if err != nil {
		log.Fatalf("client: dial: %s", err)
	}
	defer conn.Close()
	log.Println("client: connected to: ", conn.RemoteAddr())
	state := conn.ConnectionState()
	for _, v := range state.PeerCertificates {
		fmt.Println("Client: Server public key is:")
		fmt.Println(x509.MarshalPKIXPublicKey(v.PublicKey))
	}
	log.Println("client: handshake: ", state.HandshakeComplete)
	log.Println("client: mutual: ", state.NegotiatedProtocolIsMutual)
	message := "Hello\n"
	n, err := io.WriteString(conn, message)
	if err != nil {
		log.Fatalf("client: write: %s", err)
	}
	log.Printf("client: wrote %q (%d bytes)", message, n)
	reply := make([]byte, 256)
	n, err = conn.Read(reply)
	log.Printf("client: read %q (%d bytes)", string(reply[:n]), n)
	log.Print("client: exiting")
}
