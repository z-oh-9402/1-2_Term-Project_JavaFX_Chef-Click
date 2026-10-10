package mobilefood;

import javafx.scene.control.ScrollPane;

public class ScrollStyle {
    private static final String CSS = ScrollStyle.class.getResource("scrollbar.css").toExternalForm();

    // Slim scrollbars, no horizontal bar: the content is made to fit the pane width instead.
    public static void apply(ScrollPane pane)
    {
        pane.getStylesheets().add(CSS);
        pane.setFitToWidth(true);
        pane.setHbarPolicy(ScrollPane.ScrollBarPolicy.NEVER);
    }
}
