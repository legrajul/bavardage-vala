namespace Bavardage.Client.Widgets {
    public class MainWindow: Gtk.ApplicationWindow {

        public MainWindow (Gtk.Application app) {
            this.set_application (app);
            this.set_title ("Bavardage");
            this.resize (600, 400);
        }
    }
}
