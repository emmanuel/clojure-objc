# Clojure in Objective-C

This project aims to (eventually) produce an implementation of Clojure in Objective-C. This will allow development of native Mac & iPhone applications using Clojure (among other things).

Currently it is far from that goal.

The path to a full implementation is conceived as follows:

1. [ ] Implement language data structures:
  1. [x] Persistent List (though not thoroughly tested)
  2. [x] Persistent Vector (though not thoroughly tested)
  3. [ ] Persistent Hash Map (in progress & not thoroughly tested)
  4. [ ] Persistent Set (built on top of Persistent Hash Map, so should follow quickly)
2. [ ] Implement the reader (LispReader.java)
3. [ ] Implement the compiler (Compiler.java)
