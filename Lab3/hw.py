import time

from web3 import Web3
import json

from web3.exceptions import TransactionNotFound

from ethirium.secrets import INFRUA_URI, PRIVATE_KEY, ACCOUNT_ADDRESS, CONTRACT_ADDRESS

w3 = Web3(Web3.HTTPProvider(INFRUA_URI))


with open('abi.json', 'r') as file:
    abi_data = json.loads(file.read())


contract = w3.eth.contract(address=CONTRACT_ADDRESS, abi=abi_data)


def update_data(new_value):
    nonce = w3.eth.get_transaction_count(ACCOUNT_ADDRESS)
    txn_dict = {
        'chainId': 11155111,
        'gas': 3000000,
        'gasPrice': w3.to_wei('1', 'gwei'),
        'nonce': nonce,
    }
    txn_tran = contract.functions.updateData(new_value).build_transaction(txn_dict)
    signed_txn = w3.eth.account.sign_transaction(txn_tran, private_key=PRIVATE_KEY)
    txn_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)

    while True:
        try:
            txn_receipt = w3.eth.get_transaction_receipt(txn_hash)
            print(txn_receipt)
            break
        except TransactionNotFound:
            time.sleep(1)


def get_data():
    current_data = contract.functions.data().call()
    current_user = contract.functions.getLastUpdatedBy().call()
    print(f"Current Data: {current_data}\tCurrent User: {current_user}")
    return current_data


def main():
    current_data = get_data()

    current_data += 1

    update_data(current_data)

    get_data()


if __name__ == '__main__':
    main()
