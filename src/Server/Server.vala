using Gee;

namespace Bavardage.Server {

    public class Server: Granite.Application {
        static construct {
            DEBUG = true;
        }
        construct {
			program_name = "Bavardage";
			exec_name = "bavardage-server";
			
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
        
        private Socket listening_socket;

        private Gee.MultiMap<string, string> rooms;
        private Gee.Map<string, string> admins;
        
        public Server (string address, uint16 port) {
            Granite.Services.Logger.initialize ("bavardate-server");
            Granite.Services.Logger.DisplayLevel = Granite.Services.LogLevel.DEBUG;
            try {
                // Setting up the listening socket
                this.listening_socket = new Socket (SocketFamily.IPV4, SocketType.STREAM, SocketProtocol.TCP);
                var sa = new InetSocketAddress (new InetAddress.from_string (address), port);
                this.listening_socket.bind (sa, true);
                listening_socket.set_listen_backlog (10);
                listening_socket.listen ();

                // Setting up the rooms map
                rooms = new Gee.HashMultiMap<string, string> ();
                admins = new Gee.HashMap<string, string> ();

                while (true) {
                    try {
                        Socket client;
                        client = listening_socket.accept ();
                        on_incoming_connection (client);
                    } catch (Error e) {
                        stderr.printf (e.message);
                        break;
                    }
                }
            } catch (GLib.Error e) {
                print (e.message);
            }
        }

        private bool on_incoming_connection (Socket client) {
            message ("Got incoming connection");
            // Process the request asynchronously
            process_request.begin (client);
            return true;
        }

        private async void process_request (Socket client) {
            uint8 buffer[1024];
            while (true) {
                try {
                    ssize_t l = client.receive (buffer);
                    buffer[l] = '\0';
                    StringBuilder s = new StringBuilder ();
                    for (int i = 0; i <= l; i++) {
                        s.append_c ((char) buffer[i]);
                    }
                    Bavardage.Services.Message m = new Bavardage.Services.Message.from_string (buffer);
                    message ("m.code = %d, m.sender = %s, m.receiver = %s, m.content = %s\n", m.code, (string) m.sender, (string) m.receiver, (string) m.content);
                    switch (m.code) {
                        case Bavardage.Services.MessageCode.CONNECT:
                            break;

                        case Bavardage.Services.MessageCode.DISCONNECT:
                            break;

                        case Bavardage.Services.MessageCode.JOIN_ROOM:
                            join_room ((string) m.content, (string) m.sender);
                            break;

                        case Bavardage.Services.MessageCode.QUIT_ROOM:
                            break;

                        case Bavardage.Services.MessageCode.PM:
                            break;

                        default:
                            break;
                    }
                    break;
                } catch (Error e) {
                    stdout.printf (e.message);
                    break;
                }
            }
        }
        
        public void join_room (string room_name, string user_name) {
            message ("BEGIN join_room, room_name: %s, user_name: %s", room_name, user_name);

            message ("END join_room");
        }

        public void quit_room (string room_name, string user_name) {

        }
        
    }
}

public static void main (string[] args) {
    new Bavardage.Server.Server ("127.0.0.1", 10000);
}
