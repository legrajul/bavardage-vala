namespace Bavardage.Services {
    public enum MessageCode {
        CONNECT, DISCONNECT,
        JOIN_ROOM, QUIT_ROOM,
        PM
    }
    
    public struct Message {
        uint8 code;
        uint8 sender[64];
        uint8 receiver[64];
        uint8 content[2048];
    }

    public uint8[] message_to_string (Message m) {
        message ("BEGIN message_to_string");
        uint8[] res = {};
        res += m.code;
        for (int i = 0; i < 64; i++) {
            res += m.sender[i];
        }

        for (int i = 0; i < 64; i++) {
            res += m.receiver[i];
        }

        for (int i = 0; i < 2048; i++) {
            res += m.content[i];
        }

        message ("END message_to_string");
        return res;
    }

    public Message build_message (uint8 code, string sender, string receiver, string content) {
        message ("BEGIN build_message, code: %d, sender: %s, receiver: %s, content: %s", code, sender, receiver, content);
        Message m = { code, sender.data, receiver.data, content.data };
        message ("END build_message");
        return m;
    }

    public Message string_to_message (uint8[] s) {
        message ("BEGIN string_to_message");
        Message m = { -1, "".data, "".data, "".data };
        m.code = s[0];

        for (int i = 0; i < 64; i++) {
            m.sender[i] = s[i+1];
            m.receiver[i] = s[i+65];
        }

        for (int i = 0; i < 2048; i++) {
            m.content[i] = s[i+129];
        }
        
        message ("END string_to_message");
        return m;
    }
}
