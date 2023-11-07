# LAB2: Simple Randomization and Constraints

## Objective
The objective of this lab is to add support for constrained randomization of packet properties.

## Properties to Randomize and Constraint
- **Randomize**: 'target', 'data'
- **Constraint**: 'target'
  - Target is not zero.
  - Target and source don't have the same bit set.

## Random Packet Testing
1. Randomized and printed the packet instance 10 times.
2. Checked the result and debug.
3. Forced a constraint violation.

## Conditional Constraints
- **Randomize Property**: 'ptype'
- **Conditional Constraint Property**: 'target'
  - Used inside operators in the constraints.
- **Inline Constraint**: 'ptype'
  - To avoid 'ptype' being 'ANY'.
