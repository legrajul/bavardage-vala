using Gtk;
namespace Bavardage.Client {

    public class Client: Granite.Application {
        static construct {
            DEBUG = true;
        }
        construct {
			program_name = "Bavardage";
			exec_name = "bavardage-client";
			
			build_data_dir = Constants.DATADIR;
			build_pkg_data_dir = Constants.PKGDATADIR;
			build_release_name = Constants.RELEASE_NAME;
			build_version = Constants.VERSION;
			build_version_info = Constants.VERSION_INFO;
			
			app_years = "2013";
			app_icon = "mail-message-new";
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
        
        private Gee.Map<string, Bavardage.Services.Account> accounts;

        public Client () {
            //TODO: init the client state
            accounts = new Gee.HashMap<string, Bavardage.Services.Account> ();
        }
        
        protected override void activate () {
            // Create the window of this application and show it
            Gtk.ApplicationWindow window = new Bavardage.Client.Widgets.MainWindow (this);
            window.destroy.connect ( () => {
                foreach (Bavardage.Services.Account acc in accounts.values) {
                    acc.connection.close ();
                }
                Gtk.main_quit ();
            });
            window.show_all ();
        }
        
        
        protected async void process_receiving (SocketConnection conn) {
            while (true) {
                
            }
        }
        
        public bool add_account (string account_name, string server_address, int server_port, string login, string email) {
            try {
                var account = new Bavardage.Services.Account (login, login, email, server_address, server_port);
                accounts.set (account_name, account); 
                return true;
            } catch (Bavardage.Services.ErrorTypeAccount eta) {
                debug ("%s", eta.message);
                return false;
            } catch (GLib.Error e) {
                return false;
            }
        }
        
    }
    
    static void main (string[] args) {
        Bavardage.Services.Message m = new Bavardage.Services.Message ( Bavardage.Services.MessageCode.JOIN_ROOM, "toto".data, "".data, "salon1".data);

        // Connect
        try {
            var client = new SocketClient ();
            var conn = client.connect (new InetSocketAddress (new InetAddress.from_string ("127.0.0.1"), 10000));

            conn.output_stream.write (m.to_string ());
        } catch (Error e) {
            stdout.printf (e.message);
        }
        Gtk.init (ref args);
        var app = new Bavardage.Client.Client ();
        app.run (args);
    }
}
