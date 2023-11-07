# Output's Observations

## Randomization Testing

![code1](code1.png)

To test randomization, we edited `packet_test.sv` to randomize and print 10 instances of the packet. When running the simulation, we checked the constraints, ensuring that the target is not zero, and the source and target bits do not match.

![Before Constraint Violation](before_constraint_violation_1.png)


## Randomization Failure
We can force a constraint violation by adding the inline constraint for `target = 4'hf` and then print the packet.

![code2](code2.png)

We should then see the constraint violation report, which tells us that randomization failed and prints the conflicting constraints. These include the declarative `ts_bits` constraint from the packet class and the inline constraint `target = 4'hf`.

![After Forced Constraint Violation](after_forced_constraint_violation_2.png)



![SV_2](SV_2.png)

What happens to the packet properties when randomization fails? The key point is that the packet print after randomization failure is exactly the same as the packet print before the failure. So, when randomization fails, nothing is changed in the packet, and it is as if the randomization was never called.

![SV_3](SV_3.png)

## Conditional Constraints

The optional part of this lab is to declare `ptype` as `rand` and add conditional constraints for `target` depending on `ptype`. In the test module, add the inline constraint to prevent `ptype` from being `ANY` and unconstrained. Then rerun the simulation.

Note: You will not get any BROADCAST packets as the `ts_bits` constraint prevents `target` from being `4'hf`. You should see more MULTICAST packets than SINGLE, as there are 10 possible targets for MULTICAST and only 4 for SINGLE. Therefore, with default ordering, MULTICAST packets are approximately twice as likely. Here, there are 7 Multicast to 3 Single.

![SV_4](SV_4.png)

If you add an order constraint to solve `ptype` before `target`, you should get a more even distribution. Here, there are 6 Single to 4 Multicast. You may need to generate more packets to see the distribution difference.

![SV_5](SV_5.png)

## Generating Broadcast Packets

There is no easy way to generate Broadcast packets. We cannot easily turn off the `ts_bits` constraint from within the conditional constraint. However, we could comment out the `ts_bits` constraint and add the expression into the conditional branches for Single and Multicast packets. Remember that multiple constraints in each branch need to be enclosed in brackets.

When we simulate now, we should generate Broadcast packets.

![SV_6](SV_6.png)
