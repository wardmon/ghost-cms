By Yiming Sun

You may have come across some complex, hard-to-read Boolean expressions in your codebase and wished they were easier to understand. For example, let's say we want to decide whether a pizza is fantastic:

| // Decide whether this pizza is fantastic.if ((!pepperoniService.empty() \|| sausages.size() > 0) && (useOnionFlag.get() | | hasMushroom(ENOKI, PORTOBELLO)) && hasCheese()) { ...} |
| ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------- |

A first step toward improving this is to extract the condition into a well-named variable:

| boolean isPizzaFantastic =  (!pepperoniService.empty() \|| sausages.size() > 0) && (useOnionFlag.get() | | hasMushroom(ENOKI, PORTOBELLO)) && hasCheese();if (isPizzaFantastic) { ... } |
| ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |

However, the Boolean expression is still too complex. It's potentially confusing to calculate the value of isPizzaFantastic from a given set of inputs.You might need to grab a pen and paper, or start a server locally and set breakpoints. 

Instead, try to group the details into intermediate Booleans that provide meaningful abstractions. Each Boolean below represents a single well-defined quality, and you no longer need to mix && and || within an expression. Without changing the business logic, you’ve made it easier to see how the Booleans relate to each other:

| boolean hasGoodMeat = !pepperoniService.empty() \|| sausages.size() > 0;boolean hasGoodVeggies = useOnionFlag.get() | | hasMushroom(ENOKI, PORTOBELLO);boolean isPizzaFantastic = hasGoodMeat && hasGoodVeggies && hasCheese(); |
| ------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |

Another option is tohide the logic in a separate method. This also offers the possibility of early returns using [guard clauses](https://testing.googleblog.com/2017/06/code-health-reduce-nesting-reduce.html), further reducing the need to keep track of intermediate states:

| boolean isPizzaFantastic() { if (!hasCheese()) { return false; } if (pepperoniService.empty() && sausages.size() == 0) { return false; } return useOnionFlag.get() \|| hasMushroom(ENOKI, PORTOBELLO);} |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

_This is another post in our [Code Health](https://testing.googleblog.com/2017/04/code-health-googles-internal-code.html) series. A version of this post originally appeared in Google bathrooms worldwide as a Google [Testing on the Toilet](https://testing.googleblog.com/2007/01/introducing-testing-on-toilet.html) episode._ _You can download a [printer-friendly version](https://docs.google.com/document/d/11nk0lxX6DHBq8AJtMtJnnLKf5CG3KTcntUBhVTKWRLg/edit) to display in your office._

By Yiming Sun

You may have come across some complex, hard-to-read Boolean expressions in your codebase and wished they were easier to understand. For example, let's say we want to decide whether a pizza is fantastic:

| // Decide whether this pizza is fantastic.if ((!pepperoniService.empty() \|| sausages.size() > 0) && (useOnionFlag.get() | | hasMushroom(ENOKI, PORTOBELLO)) && hasCheese()) { ...} |
| ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------- |

A first step toward improving this is to extract the condition into a well-named variable:

| boolean isPizzaFantastic =  (!pepperoniService.empty() \|| sausages.size() > 0) && (useOnionFlag.get() | | hasMushroom(ENOKI, PORTOBELLO)) && hasCheese();if (isPizzaFantastic) { ... } |
| ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |

However, the Boolean expression is still too complex. It's potentially confusing to calculate the value of isPizzaFantastic from a given set of inputs.You might need to grab a pen and paper, or start a server locally and set breakpoints. 

Instead, try to group the details into intermediate Booleans that provide meaningful abstractions. Each Boolean below represents a single well-defined quality, and you no longer need to mix && and || within an expression. Without changing the business logic, you’ve made it easier to see how the Booleans relate to each other:

| boolean hasGoodMeat = !pepperoniService.empty() \|| sausages.size() > 0;boolean hasGoodVeggies = useOnionFlag.get() | | hasMushroom(ENOKI, PORTOBELLO);boolean isPizzaFantastic = hasGoodMeat && hasGoodVeggies && hasCheese(); |
| ------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |

Another option is tohide the logic in a separate method. This also offers the possibility of early returns using [guard clauses](https://testing.googleblog.com/2017/06/code-health-reduce-nesting-reduce.html), further reducing the need to keep track of intermediate states:

| boolean isPizzaFantastic() { if (!hasCheese()) { return false; } if (pepperoniService.empty() && sausages.size() == 0) { return false; } return useOnionFlag.get() \|| hasMushroom(ENOKI, PORTOBELLO);} |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |