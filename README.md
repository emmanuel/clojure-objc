# Clojure in Objective-C

This project aims to (eventually) produce an implementation of Clojure in Objective-C. This will allow development of native Mac & iPhone applications using Clojure (among other things).

Currently it is far from that goal.

The path to a full implementation is conceived as follows:

* [ ] Implement language data structures:
  * [x] Persistent List (though not thoroughly tested)
  * [x] Persistent Vector (though not thoroughly tested)
  * [ ] Persistent Hash Map (in progress & not thoroughly tested)
  * [ ] Persistent Set (built on top of Persistent Hash Map, so should follow quickly)
* [ ] Implement the reader (LispReader.java)
* [ ] Implement the compiler (Compiler.java)
