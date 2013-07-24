namespace Bavardage.Services {
    public struct Message {
        uint8 code;
        uint8 sender[64];
        uint8 receiver[64];
        uint8 content[2048];
    }

    public uint8[] message_to_string (Message m) {
        uint8[] res = {};
        res[0] = m.code;
        for (int i = 0; i < 64; i++) {
            res[i+1] = m.sender[i];
            res[i+65] = m.receiver[i];
        }

        for (int i = 0; i < 2048; i++) {
            res[i+127] = m.content[i];
        }

        return res;
    }

    public Message string_to_message (uint8[] s) {
        Message m = { -1, "".data, "".data, "".data };
        m.code = s[0];

        for (int i = 0; i < 64; i++) {
            m.sender[i] = s[i+1];
            m.receiver[i] = s[i+65];
        }

        for (int i = 0; i < 2048; i++) {
            m.content[i] = s[i+127];
        }

        return m;
    }
}
