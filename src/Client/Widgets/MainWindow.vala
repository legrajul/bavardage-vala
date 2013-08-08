namespace Bavardage.Client.Widgets {
    public class MainWindow: Gtk.ApplicationWindow {
        private Granite.Widgets.Welcome welcome;
        private Gtk.Box mainbox;
        private Gtk.Toolbar toolbar;
        private Gtk.ToolButton connect_button;
        private Gtk.ToolButton create_room_button;
        public Granite.Widgets.SearchBar search_bar { get; private set; }
        public Granite.Widgets.AppMenu app_menu { get; private set; }
        
        public MainWindow (Granite.Application app) {
            this.set_application (app);
//~             this.set_title ("Bavardage");
            this.resize (600, 400);
            
//~             var c = new Bavardage.Client.Widgets.Chat ();
//~             
//~             this.add (c);
//~             
//~             c.insert_message ("Trinity", "Wake up Neo...", new DateTime.now_local ());

            mainbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            this.add (mainbox);
            
            toolbar = new Gtk.Toolbar (); {
                connect_button = new Gtk.ToolButton.from_stock (Gtk.Stock.CONNECT);
                connect_button.set_tooltip_text (_("Connect to a chat server"));
                create_room_button = new Gtk.ToolButton.from_stock (Gtk.Stock.NEW);
                create_room_button.set_tooltip_text (_("Create a new chat room"));
                toolbar.insert (connect_button, -1);
                toolbar.insert (create_room_button, -1);
                
                var spring =  new Gtk.SeparatorToolItem ();
                spring.set_draw (false);
                spring.set_expand (true);
                toolbar.add (spring);
                
                search_bar = new Granite.Widgets.SearchBar (_("Search room or user..."));
                var item = new Gtk.ToolItem ();
                item.add (search_bar);
                toolbar.add (item);
                app_menu = app.create_appmenu (new Gtk.Menu ());
                item = new Gtk.ToolItem ();
                item.add (app_menu);
                toolbar.add (item);
            }
            mainbox.pack_start (toolbar, false);
            
            welcome = new Granite.Widgets.Welcome ("Bavardage", _("Your secure chat"));
			welcome.append ("add", _("Create Account"), _("Create a new account"));
                
            mainbox.pack_start (welcome);
        }
    }
}
