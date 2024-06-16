Credit: ChatGpt lol

1. **Avoiding Global Variables**
   - Minimize the use of global variables as they are slower to access than local variables.

2. **Using Local Variables**
   - Local variables are faster to access than global variables. Use them wherever possible.

3. **Efficient Looping**
   - Use `for` loops instead of `while` loops when the number of iterations is known to reduce overhead.

4. **Reducing Function Calls**
   - Function calls have overhead. Reduce the number of function calls in performance-critical sections.

5. **Inlining Functions**
   - For small, frequently called functions, consider inlining the function code to reduce call overhead.

6. **Using Numeric For Loops**
   - Numeric for loops are generally faster than generic for loops. Use them when iterating over numerical ranges.

7. **Table Preallocation**
   - Preallocate table size if known in advance to avoid dynamic resizing during runtime.

8. **Avoiding Unnecessary Object Creation**
   - Reuse objects when possible to reduce garbage collection overhead.

9. **Minimizing Table Lookups**
   - Store table values in local variables if accessed frequently within a function to avoid slow table lookups.

10. **Avoiding String Concatenation in Loops**
    - Use `table.concat` for concatenating multiple strings instead of concatenating them in loops.

11. **Using Coroutines for Asynchronous Tasks**
    - Manage asynchronous tasks with coroutines to improve performance and responsiveness.

12. **Optimizing Physics and Rendering**
    - Limit the number of physics calculations and rendering updates, using debounce techniques if necessary.

13. **Debouncing and Throttling Events**
    - Use debounce or throttle techniques to limit the frequency of event handlers for frequent events.

14. **Batching Operations**
    - Batch operations together to reduce the overhead of performing individual operations multiple times.

15. **Using Metatables and Metamethods Wisely**
    - Use metatables to optimize access patterns and enable custom behavior, but avoid unnecessary complexity and overhead.

16. **Optimizing Network Usage**
    - Minimize data sent over the network by reducing the frequency and size of data transmissions.

17. **Memory Management**
    - Manage memory usage by avoiding memory leaks, clearing unused references, and understanding the garbage collection process in Lua.

18. **Profile and Benchmark Code**
    - Regularly profile and benchmark your code using Roblox's built-in tools to identify and address performance bottlenecks.

19. **Leveraging Roblox Services Efficiently**
    - Use Roblox services efficiently by understanding their performance characteristics and limitations.

20. **Optimizing User Interface (UI)**
    - Optimize UI elements by reducing the number of GUI updates and ensuring complex UI logic does not run every frame.
