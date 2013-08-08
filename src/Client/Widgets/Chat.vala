namespace Bavardage.Client.Widgets {
    
    public enum AlertLevel {
        INFO, WARNING, ERROR
    }
        
    public class Chat: Gtk.TextView {
        
        public Chat () {
            var buffer = new Gtk.TextBuffer (new Gtk.TextTagTable ());
            buffer.create_tag ("blue", "foreground", "#0000FF", "underline", Pango.Underline.SINGLE);
            buffer.create_tag ("green", "foreground", "#00FF00");
            buffer.create_tag ("orange", "foreground", "#FF7400");
            buffer.create_tag ("red", "foreground", "#FF0000", "weight", Pango.Weight.BOLD);
            buffer.create_tag ("usernametag", "weight", Pango.Weight.BOLD);
            
            this.set_buffer (buffer);
            
            this.set_editable (false);
        }
        
        public void insert_message (string user, string message, DateTime time) {
            //TODO implémenter l'insertion formatée d'un message
            string t = time.format ("[%H:%M:%S] ");
            this.buffer.insert_at_cursor (t, t.length);
            Gtk.TextIter end;
            this.buffer.get_end_iter (out end);
            this.buffer.insert_with_tags_by_name (end, user, user.length, "usernametag", null);
            
            this.buffer.insert_at_cursor (": " + message  + "\n", message.length + 3);
        }
        
        public void insert_alert (AlertLevel level, string message) {
            //TODO implémenter l'insertion formatée d'une alerte
        }
    }
}
