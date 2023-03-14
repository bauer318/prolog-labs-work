% Copyright

implement taskWindow
    inherits applicationWindow
    open core, vpiDomains

constants
    mdiProperty : boolean = true.

clauses
    new() :-
        applicationWindow::new(),
        generatedInitialize().

predicates
    onShow : window::showListener.
clauses
    onShow(_, _CreationData) :-
        _MessageForm = messageForm::display(This).

class predicates
    onDestroy : window::destroyListener.
clauses
    onDestroy(_).

class predicates
    onHelpAbout : window::menuItemListener.
clauses
    onHelpAbout(TaskWin, _MenuTag) :-
        _AboutDialog = aboutDialog::display(TaskWin).

predicates
    onFileExit : window::menuItemListener.
clauses
    onFileExit(_, _MenuTag) :-
        close().

predicates
    onSizeChanged : window::sizeListener.
clauses
    onSizeChanged(_) :-
        vpiToolbar::resize(getVPIWindow()).

predicates
    onFileNew : window::menuItemListener.
clauses
    onFileNew(W, _MenuTag):-S=fCinemas::new(W),
                                        S:show().

predicates
    onEditUndo : window::menuItemListener.
clauses
    onEditUndo(_Source, _MenuTag):-stdio::write("Название ", " Режиссер ","\n"),
                                                cCinemas::кинофильм_п(_,Film,_,Reg,_),
                                                stdIO::write(Film ," - ",Reg,"\n"),fail.
    onEditUndo(_Source, _MenuTag).

predicates
    onEditRedo : window::menuItemListener.
clauses
    onEditRedo(_Source, _MenuTag):-cCinemas::кинотеатр_п(_,Cine,_,_,_),
                                                stdio::write(Cine,"\n"),fail.
    onEditRedo(_Source, _MenuTag).

predicates
    onHelpContents : window::menuItemListener.
clauses
    onHelpContents(_Source, _MenuTag):-cCinemas::загрузитьБД().


predicates
    onHelpLocal : window::menuItemListener.
clauses
    onHelpLocal(_Source, _MenuTag):-cCinemas::сохранитьБД().

% This code is maintained automatically, do not update it manually. 10:15:35-14.3.2023
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("Cinemas"),
        setDecoration(titlebar([closeButton,maximizeButton,minimizeButton])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings]),
        whenCreated({ :- projectToolbar::create(getVpiWindow()) }),
        addSizeListener({ :- vpiToolbar::resize(getVpiWindow()) }),
        setMdiProperty(mdiProperty),
        menuSet(resMenu(resourceIdentifiers::id_TaskMenu)),
        addShowListener(onShow),
        addSizeListener(onSizeChanged),
        addDestroyListener(onDestroy),
        addMenuItemListener(resourceIdentifiers::id_help_about, onHelpAbout),
        addMenuItemListener(resourceIdentifiers::id_file_exit, onFileExit),
        addMenuItemListener(resourceIdentifiers::id_file_new, onFileNew),
        addMenuItemListener(resourceIdentifiers::id_edit_undo, onEditUndo),
        addMenuItemListener(resourceIdentifiers::id_edit_redo, onEditRedo),
        addMenuItemListener(resourceIdentifiers::id_help_contents, onHelpContents),
        addMenuItemListener(resourceIdentifiers::id_help_local, onHelpLocal).
% end of automatic code
end implement taskWindow