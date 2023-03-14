% Copyright

implement fCinemas
    inherits formWindow
    open core, vpiDomains,cCinemas


clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().

predicates
    onPushButtonClick : button::clickResponder.
clauses
    onPushButtonClick(_Source) = button::defaultAction:-
                                            Film=toTerm(tostring(edit_ctl:getText())),
                                            телефон_кинотеатра_п(Tel,Film),
                                            listbox_ctl:add(Tel),fail.
    onPushButtonClick(_Source) = button::defaultAction.

predicates
    onPushButton2Click : button::clickResponder.
clauses
    onPushButton2Click(_Source) = button::defaultAction:-listbox_ctl:clearAll().

predicates
    onPushButton1Click : button::clickResponder.
clauses
    onPushButton1Click(_Source) = button::defaultAction:-
                                            Reg = toTerm(tostring(edit1_ctl:getText())),
                                            кинотеатр_режиссер_п(Reg,Cine),
                                            listbox1_ctl:add(Cine),fail.
    onPushButton1Click(_Source) = button::defaultAction.

predicates
    onPushButton3Click : button::clickResponder.
clauses
    onPushButton3Click(_Source) = button::defaultAction:-listbox1_ctl:clearAll().

% This code is maintained automatically, do not update it manually. 17:08:52-13.3.2023
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    edit_ctl : editControl.
    edit1_ctl : editControl.
    pushButton_ctl : button.
    pushButton1_ctl : button.
    pushButton2_ctl : button.
    listbox1_ctl : listBox.
    pushButton3_ctl : button.
    listbox_ctl : listBox.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("FCinemas"),
        setRect(rct(50,40,322,257)),
        setDecoration(titlebar([closeButton,maximizeButton,minimizeButton])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(8, 196),
        ok_ctl:setSize(36, 16),
        ok_ctl:defaultHeight := false,
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(108, 194),
        cancel_ctl:setSize(44, 16),
        cancel_ctl:defaultHeight := false,
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(212, 194),
        help_ctl:setSize(40, 16),
        help_ctl:defaultHeight := false,
        help_ctl:setAnchors([control::right,control::bottom]),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Нужный фильм :"),
        StaticText_ctl:setPosition(4, 8),
        StaticText_ctl:setSize(60, 10),
        edit_ctl := editControl::new(This),
        edit_ctl:setText(""),
        edit_ctl:setPosition(72, 6),
        edit_ctl:setWidth(96),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Имя режиссера :"),
        StaticText1_ctl:setPosition(4, 28),
        StaticText1_ctl:setSize(60, 10),
        edit1_ctl := editControl::new(This),
        edit1_ctl:setText(""),
        edit1_ctl:setPosition(72, 26),
        edit1_ctl:setWidth(96),
        StaticText2_ctl = textControl::new(This),
        StaticText2_ctl:setText("Телефон кинотеатров, показывающих нужному фильму"),
        StaticText2_ctl:setPosition(4, 50),
        StaticText2_ctl:setSize(200, 10),
        pushButton_ctl := button::new(This),
        pushButton_ctl:setText("Найти телефон"),
        pushButton_ctl:setPosition(184, 4),
        pushButton_ctl:setWidth(56),
        pushButton_ctl:defaultHeight := true,
        pushButton_ctl:setClickResponder(onPushButtonClick),
        pushButton1_ctl := button::new(This),
        pushButton1_ctl:setText("Найти кинотеатры"),
        pushButton1_ctl:setPosition(180, 26),
        pushButton1_ctl:setWidth(68),
        pushButton1_ctl:defaultHeight := true,
        pushButton1_ctl:setClickResponder(onPushButton1Click),
        pushButton2_ctl := button::new(This),
        pushButton2_ctl:setText("Очистить"),
        pushButton2_ctl:setPosition(124, 86),
        pushButton2_ctl:setWidth(56),
        pushButton2_ctl:defaultHeight := true,
        pushButton2_ctl:setClickResponder(onPushButton2Click),
        StaticText3_ctl = textControl::new(This),
        StaticText3_ctl:setText("Кинотеатры, в которых идут филмы заданного режиссера"),
        StaticText3_ctl:setPosition(4, 124),
        StaticText3_ctl:setSize(160, 10),
        listbox1_ctl := listBox::new(This),
        listbox1_ctl:setPosition(4, 138),
        listbox1_ctl:setSize(116, 50),
        pushButton3_ctl := button::new(This),
        pushButton3_ctl:setText("Очистить"),
        pushButton3_ctl:setPosition(128, 154),
        pushButton3_ctl:setWidth(56),
        pushButton3_ctl:defaultHeight := true,
        pushButton3_ctl:setClickResponder(onPushButton3Click),
        listbox_ctl := listBox::new(This),
        listbox_ctl:setPosition(8, 68),
        listbox_ctl:setSize(108, 50).
% end of automatic code
end implement fCinemas