namespace Bavardage.Client.Widgets {
    public class MainWindow: Gtk.ApplicationWindow {

        public MainWindow (Gtk.Application app) {
            this.set_application (app);
            this.set_title ("Bavardage");
            this.resize (600, 400);
            
            var c = new Bavardage.Client.Widgets.Chat ();
            
            this.add (c);
            
            c.insert_message ("Trinity", "Wake up Neo...", new DateTime.now_local ());
        }
    }
}
