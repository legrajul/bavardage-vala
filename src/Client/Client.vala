namespace Bavardage.Client {

    public class Client: GLib.Application {
        private Bavardage.Services.Account current_account;

        public Client () {
            Object(application_id: "bavardage.client", flags: ApplicationFlags.FLAGS_NONE);
            current_account = new Bavardage.Services.Account ("toto", "John Doe", "example@server.net");
        }
    }
    
    static void main (string[] args) {
        stdout.printf ("Message creation\n");
        Bavardage.Services.Message m = {-1, "".data, "".data, "".data };
        m.code = Bavardage.Services.MessageCode.JOIN_ROOM;
        m.sender = "toto".data;
        m.receiver = "".data;
        m.content = "salon1".data;

        // Connect
        stdout.printf ("Connection\n");
        try {
            var client = new SocketClient ();
            var conn = client.connect (new InetSocketAddress (new InetAddress.from_string ("127.0.0.1"), 10000));

            // Send HTTP GET request;
            stdout.printf ("Sending message\n");  
            conn.output_stream.write (Bavardage.Services.message_to_string (m));
        } catch (Error e) {
            stdout.printf (e.message);
        }
    }
}
