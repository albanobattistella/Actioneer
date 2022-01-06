using Gtk;

public class BoxList : Box {

  private Box _list_box;

  /* Default constructor */
  public BoxList( string add_label ) {

    Object( orientation: Orientation.VERTICAL, spacing: 0 );

    _list_box = new Box( Orientation.VERTICAL, 0 );

    var add_btn = new Button.with_label( add_label );
    add_btn.clicked.connect(() => {
      add_item();
    });

    var bbox = new Box( Orientation.HORIZONTAL, 0 );
    bbox.pack_start( add_btn, false, false, 0 );

    pack_start( _list_box, false, true, 0 );
    pack_start( bbox,      false, true, 0 );

  }

  private Box create_item() {

    var box = new Box( Orientation.HORIZONTAL, 0 );
    box.margin = 10;

    var mb   = get_option_menu();
    var ibox = new Box( Orientation.VERTICAL, 0 );

    mb.activated.connect((i) => {
      if( ibox.get_children().length() > 0 ) {
        ibox.remove( ibox.get_children().nth_data( 0 ) );
      }
      insert_item( i, ibox );
    });

    /* Add close button */
    var close = new Button.from_icon_name( "window-close-symbolic", IconSize.SMALL_TOOLBAR );
    close.clicked.connect(() => {
      box.parent.remove( box );
    });

    box.pack_start( mb,    false, false, 0 );
    box.pack_start( ibox,  false, true,  0 );
    box.pack_end(   close, false, false, 0 );

    return( box );

  }

  private void add_item() {
    var item = create_item();
    _list_box.pack_start( item, false, true, 0 ); 
    _list_box.show_all();
  }

  protected virtual OptMenu get_option_menu() {
    assert( false );
    return( new OptMenu() );
  }

  protected virtual void insert_item( int index, Box box ) {
    assert( false );
  }

}
