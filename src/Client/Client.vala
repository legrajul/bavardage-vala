using Gtk;
namespace Bavardage.Client {

    public class Client: Granite.Application {
        
        construct {
			program_name = "Bavardage";
			exec_name = "bavardage-client";
			
			build_data_dir = Constants.DATADIR;
			build_pkg_data_dir = Constants.PKGDATADIR;
			build_release_name = Constants.RELEASE_NAME;
			build_version = Constants.VERSION;
			build_version_info = Constants.VERSION_INFO;
			
			app_years = "2013";
			app_icon = exec_name;
			app_launcher = exec_name+".desktop";
			application_id = "net.launchpad."+exec_name;
			
			main_url = "https://github.com/legrajul/bavardage-vala";
			bug_url = "https://github.com/legrajul/bavardage-vala/issues";
			help_url = "https://github.com/legrajul/bavardage-vala/wiki";
			
			about_authors = {"Julien Legras <julomino@gmail.com>"};
			about_documenters = {"Julien Legras"};
			about_artists = {"Julien Legras"};
			about_comments = "Discuss, share in a soon-to-be secure way";
			about_translators = "";
			about_license_type = Gtk.License.GPL_3_0;
		}
        
        private Bavardage.Services.Account current_account;

        public Client () {
            //TODO: init the client state
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
