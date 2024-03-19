import List "mo:base/List";
actor {

  type Category = {
    #food;
    #clothing;
    #entertainment;
    #miscellaneous;
  };

  type Expense = {
    description : Text;
    amount : Nat;
    category : Category;
  };

  var expenses = List.nil<Expense>();

  public query func getExpenses() : async [Expense] {
    return List.toArray(expenses);
  };

  public shared func addExpense(expense : Expense) : async () {
    expenses := List.push(expense, expenses);
  };

  public query func getTotalExpenditure() : async Nat {
    var total = 0;

    List.iterate<Expense>(expenses, func e { total += e.amount });

    return total;
  };

  public query func getTotalExpenditureByCategory(category : Category) : async Nat {
    var total = 0;

    List.iterate<Expense>(
      expenses,
      func e {
        if (category == e.category) {
          total += e.amount;
        };
      },
    );

    return total;
  };

};
