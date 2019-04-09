# Extensions-For-YNAB
Extensions for YNAB is a iOS app dedicated to adding greater functionality to YNAB iOS app.

## But How Does It Work?
Extensions for YNAB uses the YNAB apis, located [here][1].

All of the code is written in Swift. And compiled via XCode.

## Getting Started
### Prerequisites
 * A computer running MacOS Mojave.
 * XCode Version 10.2
 * A Suitable Testing iOS Device. (Simulator Works Fine, However a proper device is recommended).
 
 ### Installing
  1. Clone the repository
  2. Open the `BudgetTest.xcodeproj` file
  
## Authors
 1. **Jacob Pyke** - *Initial Contributor*
 
## Licence
This project is licenced under the Apache 2.0 Licence. See [choosealicence.com][2] for more details. Or refer to the `LICENCE.md` file for more details

## TODO-Lists
### Main App
- [ ] Add abilities to input API key and fetch the user's budget catagories
- [ ] Add favoriting budget catagories to display in the other apps.
- [ ] Location-Based Category Recommendations

### iOS Widget (In the Today View)
- [ ] Display Favorited Categories from the Main App.
- [ ] Display a better looking Success screen.
- [ ] Perhaps make a "Big" version of the widget.
- [ ] Location-Based Category recommendations

### Apple Watch App
- [ ] Add the same functionality as the iOS Widget.

### Siri Suggestions
- [ ] Recommend to add a transaction based on location.

### Future Wishlist
- [ ] Split Transactions via Today Widget / Watch

  [1]: https://api.youneedabudget.com/
  [2]: https://choosealicense.com/licenses/apache-2.0/
