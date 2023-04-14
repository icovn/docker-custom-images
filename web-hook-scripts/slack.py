import json
import os
import requests
import sys

def send_message(title):
    webhook_url = os.environ['SLACK_URL']
    send_message_advance(webhook_url, title)

def send_message_advance(url, title):
    slack_data = {'text': title}
    response = requests.post(
            url, data=json.dumps(slack_data),
            headers={'Content-Type': 'application/json'}
    )
    print(response.status_code)
    if response.status_code != 200:
        raise ValueError(
                'Request to slack returned an error %s, the response is:\n%s'
                % (response.status_code, response.text)
        )

if __name__ == "__main__":
    if len(sys.argv) == 3:
        send_message_advance(sys.argv[1], sys.argv[2])
    else:
        if len(sys.argv) == 3:
            send_message(sys.argv[1])
        else:
            raise SystemExit("usage:  python discord.py <code> <title> <content>")
