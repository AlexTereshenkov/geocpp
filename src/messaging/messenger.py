from pbs import message_pb2

def main():
    text = "Text of a message"
    msg = message_pb2.Message(text=text)
    print(msg.text)
    assert msg.text == text


if __name__ == "__main__":
    main()
