using Gee;

namespace Bavardage.Server {

    public class Server: GLib.Object {
        private Socket listening_socket;

        private Gee.MultiMap<string, string> rooms;
        private Gee.Map<string, string> admins;
        
        public Server (string address, uint16 port) {
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
                    }
                }
            } catch (GLib.Error e) {
                print (e.message);
            }
        }

        private bool on_incoming_connection (Socket client) {
            stdout.printf ("Got incoming connection\n");
            // Process the request asynchronously
            process_request.begin (client);
            return true;
        }

        private async void process_request (Socket client) {
            try {
                uint8 buffer[1024];
                while (true) {
                    ssize_t l = client.receive (buffer);
                    buffer[l] = '\0';
                    StringBuilder s = new StringBuilder ();
                    for (int i = 0; i <= l; i++) {
                        s.append_c ((char) buffer[i]);
                    }
                    stdout.printf ("Message received: %s\n", (string) buffer);
                    Bavardage.Services.Message m = Bavardage.Services.string_to_message (buffer);
                    stdout.printf ("m.sender = %s, m.receiver = %s, m.content = %s\n", (string) m.sender, (string) m.receiver, (string) m.content);
                }
            } catch (Error e) {
              
            }
        }
        
        public void create_room (string room_name, string admin_name) {

        }
        
    }
}

public static void main (string[] args) {
    new Bavardage.Server.Server ("127.0.0.1", 10000);
}
