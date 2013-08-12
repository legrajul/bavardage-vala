using Gtk;
namespace Bavardage.Client.Widgets {
    public class NewAccount: Gtk.Dialog {
        public Granite.Widgets.HintedEntry entry_account_name { get; private set; }
        public Granite.Widgets.HintedEntry entry_server_ip { get; private set; }
        public Granite.Widgets.HintedEntry entry_server_port { get; private set; }
        public Granite.Widgets.HintedEntry entry_login { get; private set; }
        public Granite.Widgets.HintedEntry entry_email { get; private set; }

        public signal void connect_regular (string account_name, string server_ip, int server_port, string login, string email);

        public NewAccount (Gtk.Window parent, Gtk.Application app) {
            this.add_buttons (Gtk.Stock.CANCEL, Gtk.ResponseType.CANCEL, Gtk.Stock.CONNECT, Gtk.ResponseType.ACCEPT);
            this.set_title (_("New account"));
            this.set_modal (true);
            this.set_transient_for (parent);
            this.set_position (WindowPosition.CENTER_ON_PARENT);
            this.set_application (app);
            setup_view ();
            connect_signals ();
            this.show_all ();
            this.check_resize ();
        }


        private void setup_view () {
            entry_server_ip = new Granite.Widgets.HintedEntry (_("Server address"));
            entry_server_port = new Granite.Widgets.HintedEntry (("Server port"));
            entry_login = new Granite.Widgets.HintedEntry (_("Login"));
            entry_email = new Granite.Widgets.HintedEntry (_("Email address"));
            entry_account_name = new Granite.Widgets.HintedEntry (_("Account name"));

            var box = this.get_content_area ();
            box.set_orientation (Orientation.VERTICAL);
            
            box.pack_start (entry_server_ip);
            box.pack_start (entry_server_port);
            box.pack_start (entry_login);
            box.pack_start (entry_email);
            box.pack_start (entry_account_name);

            
        }

        private void connect_signals () {
            entry_server_ip.activate.connect ( () => {this.response (Gtk.ResponseType.ACCEPT);});
            entry_server_port.activate.connect ( () => {this.response (Gtk.ResponseType.ACCEPT);});
            entry_login.activate.connect ( () => {this.response (Gtk.ResponseType.ACCEPT);});
            entry_email.activate.connect ( () => {this.response (Gtk.ResponseType.ACCEPT);});
            entry_account_name.activate.connect ( () => {this.response (Gtk.ResponseType.ACCEPT);});
            
             this.response.connect ( (response_code) => {
                    if (response_code == Gtk.ResponseType.ACCEPT) {
                        connect_regular (entry_account_name.get_text (), 
                                entry_server_ip.get_text (), 
                                int.parse (entry_server_port.get_text ()), 
                                entry_login.get_text (), 
                                entry_email.get_text ()
                        );
                        this.destroy ();
                    } else {
                        this.destroy ();
                    }
                });
        }
    }
}
