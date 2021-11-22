# APE
Compact Kinetic Inductance Detector: Analytic Performance Estimator

The goal of this program is to be able to give performance estimates for
a Capacitively Shunted Compact Microwave Kinetic inductance Detector

This is done by making a object oriented framework in MATLAB.
In this framework it is possible to:
- Add sonnet data
- Add theoretical formulas
- Make instances of a parallel plate capacitor with certain dimensions.
- Make instances of Shorted CPW line of length l. (Currently 1mm)

Out we get the following data:
- Resonant frequencies. $F_0$
- Kinetic inductance fraction for various configurations.
- Difference between square and rectangle for the PPC.
