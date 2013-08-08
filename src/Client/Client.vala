using Gtk;
namespace Bavardage.Client {

    public class Client: Gtk.Application {
        private Bavardage.Services.Account current_account;

        public Client () {
            Object(application_id: "org.bavardage.client", flags: ApplicationFlags.FLAGS_NONE);
            current_account = new Bavardage.Services.Account ("toto", "John Doe", "example@server.net");
        }
        
        protected override void activate () {
            // Create the window of this application and show it
            Gtk.ApplicationWindow window = new Bavardage.Client.Widgets.MainWindow (this);

            window.show_all ();
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

        var app = new Bavardage.Client.Client ();
        app.run (args);
    }
}
