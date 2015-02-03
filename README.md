# SwiftEvents
Coming from actionscript 3 i have decided to integrate event system into swift. Since swift does not support function pointers, it was required to change the passing also the object self.

How to use :

1. Implement or extend the EventDispatcher in your class or some view.

2. use : 

view1.addEventListener("outerListener", withFunction : test)


3. use another dispatcher to trigger the event or the global dispatcher :
view2.dispatchEvent(Event(type: "outerListener"))
-> you shall see the function triggered

4. use removeEventListener on view1 to remove listener if no longer needed :

view1.removeEventListener("outerListener")

5. If you need to add additional data to your events extend Event class and use it when dispatching it shall come to your listener. Will implement example soon.

6. Let me know if you have some ideas, or spot a mistake.


More features to come.