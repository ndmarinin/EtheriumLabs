import time

from web3 import Web3

from ethirium.secrets import CONTRACT_ADDRESS, INFRUA_URI

w3 = Web3(Web3.HTTPProvider(INFRUA_URI))


def handle_event(event):
    print(f"Event DataUpdated: new value = {int.from_bytes(event['data'], byteorder='big')}")


def log_loop(event_filter, poll_interval):
    while True:
        for event in event_filter.get_new_entries():
            handle_event(event)
        time.sleep(poll_interval)


def main():
    block_filter = w3.eth.filter({"address": CONTRACT_ADDRESS})
    log_loop(block_filter, 2)


if __name__ == '__main__':
    main()
