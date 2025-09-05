#!/usr/bin/python3

import socket
import sys

client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client.settimeout(1.0)

message = bytes(" ".join(sys.argv[1:]), "utf-8")
address = ("127.0.0.1", 12000)
client.sendto(message, address)

try:
    data, server = client.recvfrom(1024)
    print(data.decode("utf-8").strip())
except socket.timeout:
    print("Timed out")
