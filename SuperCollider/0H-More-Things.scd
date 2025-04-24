/*
Some things that you might want to look into ...
(Look into the helpfile; there are examples)
*/

/*
Getting MIDI data (notes, controlers, ...) into SuperCollider
*/
MIDIdef


/*
Getting data from Joysticks/Gamepads into SuperCollider
*/
HID


/*
Getting OSC messages into SuperCollider
*/
OSCdef

/*
Sending OSC messages to other applications.
*/
n = NetAddr("127.0.0.1", 57140)
n.sendMsg("/bla", 5, 10);