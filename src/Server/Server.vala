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
                        break;
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
            uint8 buffer[1024];
            while (true) {
                try {
                    ssize_t l = client.receive (buffer);
                    buffer[l] = '\0';
                    StringBuilder s = new StringBuilder ();
                    for (int i = 0; i <= l; i++) {
                        s.append_c ((char) buffer[i]);
                    }
                    stdout.printf ("Message received: %s\n", (string) buffer);
                    Bavardage.Services.Message m = Bavardage.Services.string_to_message (buffer);
                    stdout.printf ("m.code = %d, m.sender = %s, m.receiver = %s, m.content = %s\n", m.code, (string) m.sender, (string) m.receiver, (string) m.content);
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
