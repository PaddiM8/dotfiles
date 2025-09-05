#!/usr/bin/python3

from phue import Bridge
from dotenv import load_dotenv
import os
import socket

def run_command(bridge, message):
    args = message.split()
    if args[0] == "bri":
        if len(args) > 1:
            for light in bridge.lights:
                light.brightness = int(float(args[1]) / 100 * 254)
            return "Set brightness to {}%".format(args[1])
        else:
            percentages = [str(light.brightness * 100 // 254) + "%" for light in bridge.lights]
            return "\n".join(percentages)
    if args[0] == "temp":
        if len(args) > 1:
            for light in bridge.lights:
                light.colortemp = int(float(args[1]) / 100 * 346) + 154
            return "Set temp to {}%".format(args[1])
        else:
            percentages = [str(light.temp * 100 // 346 - 154) + "%" for light in bridge.lights]
            return "\n".join(percentages)
    if args[0] == "scene":
        if len(args) > 1:
            bridge.run_scene(os.getenv("BRIDGE_ROOM"), args[1])
            return "Set scene to {}".format(args[1])
        else:
            return "\n".join([scene.name for scene in bridge.scenes])
    if args[0] == "help":
        return "bri [0-100] - get/set brightness\ntemp [0-100] - get/set temperature\nscene [name] - get a list of all scenes or run a scene"

    return "Invalid command"

def init():
    load_dotenv()
    bridge = Bridge(os.getenv("BRIDGE_IP"))
    bridge.connect()

    server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    server.bind(("", 12000))

    while True:
        message, client = server.recvfrom(1024)
        message = message.decode("utf-8").strip()
        result = run_command(bridge, message)
        server.sendto(bytes(result + "\n", "utf-8"), client)


if __name__ == "__main__":
    init()
