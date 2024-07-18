import x11/x
import x11/xlib

const XFixesSetSelectionOwnerNotifyMask = int(1) shl 0

const libXfixes* = "libXfixes.so"

proc XFixesSelectSelectionInput*(dpy: PDisplay, win: Window; selection: Atom, eventMask: cint) {. cdecl, dynlib: libXfixes, importc: "XFixesSelectSelectionInput".}

var
  disp*: PDisplay
  root: Window
  clip: Atom
  evt: XEvent

disp = XOpenDisplay(nil)

if disp == nil:
  quit "Failed to open display"

root = DefaultRootWindow(disp)

clip = XInternAtom(disp, "CLIPBOARD", false.XBool)

XFixesSelectSelectionInput(disp, root, clip, XFixesSetSelectionOwnerNotifyMask)

discard XNextEvent(disp, evt.addr)
discard XCloseDisplay(disp)
