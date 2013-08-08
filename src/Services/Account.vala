namespace Bavardage.Services {
    public class Account: GLib.Object {
        [Description(nick = "Username", blurb = "This is the username used on the server")]
        public string name { get; private set; }

        [Description(nick = "Real name", blurb = "This is the real name of the user")]
        public string realname { get; private set; }

        [Description(nick = "Email address", blurb = "This is the email address of the user")]
        public string email { get; private set; }

        public string server_address { get; private set; default = "localhost"; }
        public int server_port { get; private set; default = 10000; }
          
        public Account (string name, string realname, string email) {
            this.name     = name;
            this.realname = realname;
            this.email    = email;

            this.notify.connect((s, p) => {
                stdout.printf("Property '%s' has changed!\n", p.name);
            });
        }

    }
}
