namespace Bavardage.Services {
    
    public enum MessageCode {
        CONNECT, DISCONNECT,
        JOIN_ROOM, QUIT_ROOM,
        PM
    }
    
    public class Message: GLib.Object {
        public uint8 code { get; set; default = -1; }
        public uint8[] sender { get; set; default = "".data; }
        public uint8[] receiver { get; set; default = "".data; }
        public uint8[] content { get; set; default = "".data; }
        
        public Message (uint8 code, uint8[] sender, uint8[] receiver, uint8[] content) {
            Granite.Services.Logger.initialize ("bavardate-client");
            Granite.Services.Logger.DisplayLevel = Granite.Services.LogLevel.DEBUG;
            this.sender = new uint8[64];
            this.receiver = new uint8[64];
            this.content = new uint8[2048];
            this.code = code; 
            this.sender = sender;
            this.receiver = receiver;
            this.content = content;
        }
        
        public Message.from_string (uint8[] s) {
            Granite.Services.Logger.initialize ("bavardate-client");
            Granite.Services.Logger.DisplayLevel = Granite.Services.LogLevel.DEBUG;
            debug ("BEGIN string_to_message");
            this.code = s[0];

            sender = new uint8[64];
            receiver = new uint8[64];
            content = new uint8[2048];
            
            for (int i = 0; i < 64; i++) {
                this.sender[i] = s[i+1];
                this.receiver[i] = s[i+65];
            }

            for (int i = 0; i < 2048; i++) {
                this.content[i] = s[i+129];
            }
            
            debug ("END string_to_message");
        }

        public uint8[] to_string () {
            debug ("BEGIN message_to_string");
            uint8[] res = new uint8[2176];
            res[0] = this.code;
            for (int i = 0; i < 64 && i < this.sender.length; i++) {
                res[i + 1] = this.sender[i];
            }

            for (int i = 0; i < 64 && i < this.receiver.length; i++) {
                res[i + 65] = this.receiver[i];
            }

            for (int i = 0; i < 2048 && i < this.content.length; i++) {
                res[i + 129] = this.content[i];
            }

            debug ("END message_to_string");
            return res;
        }

    }
}
