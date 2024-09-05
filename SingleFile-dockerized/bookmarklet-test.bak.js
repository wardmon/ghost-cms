(function() {
    //Just tests that the bookmarklet worked.
    //Should display an alert.

    alert("It worked!");
    fetch("https://jsonplaceholder.typicode.com/todos", {
  method: "POST",
  body: JSON.stringify({
    userId: 1,
    title: "Fix my bugs",
    completed: false
  }),
  headers: {
    "Content-type": "application/json; charset=UTF-8"
  }
})
  .then((response) => response.json())
  .then((json) => alert(JSON.stringify(json)));
})();