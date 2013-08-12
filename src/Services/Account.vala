namespace Bavardage.Services {
    public errordomain ErrorTypeAccount {
        INVALID_ARGUMENT,
        CONNECTION_FAILED
    }
    
    public class Account: GLib.Object {
        [Description(nick = "Username", blurb = "This is the username used on the server")]
        public string name { get; private set; }

        [Description(nick = "Real name", blurb = "This is the real name of the user")]
        public string realname { get; private set; }

        [Description(nick = "Email address", blurb = "This is the email address of the user")]
        public string email { get; private set; }

        public string server_address { get; private set; default = "localhost"; }
        public int server_port { get; private set; default = 10000; }
        
        public SocketConnection connection { get; private set; default = null; }
          
        public Account (string name, string realname, string email, string server_address, int server_port) throws GLib.Error {
            if (name == null || email == null || server_address == null || server_port <= 0) {
                throw new ErrorTypeAccount.INVALID_ARGUMENT (_("Invalid arguments"));
            }
            Granite.Services.Logger.initialize ("bavardate-services");
            Granite.Services.Logger.DisplayLevel = Granite.Services.LogLevel.DEBUG;
            
            this.name     = name;
            this.realname = realname;
            this.email    = email;
            
            this.server_address = server_address;
            this.server_port    = server_port;
            
            debug ("Connecting to remote %s:%d...", server_address, server_port);
            var client = new SocketClient ();
            try {
                connection = client.connect (new InetSocketAddress (new InetAddress.from_string (server_address), (uint16) server_port));
                debug ("Successful connection !");
            } catch (GLib.Error e) {
                debug ("FAILED: %s", e.message);
                throw e;
            }
        }

    }
}
