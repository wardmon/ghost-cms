(function(){ 
       var script=document.createElement('script'); 
       script.setAttribute('src',  'https://ward-myproj.pgs.sh/jquery.min.js');   
       document.getElementsByTagName('head')[0] .appendChild(script); 
       script=document.createElement('script');
       script.setAttribute('src',  'https://ward-myproj.pgs.sh/jquery.bookmarklet.js');    
       document.getElementsByTagName('head')[0] .appendChild(script);    

        // Create a new div element
        const newDiv = document.createElement("div");

        // Set some attributes (optional) http://45.32.200.249:8060/ddd?url=ddd&ddd=ls -l;ps
        newDiv.id = "myNewDiv";
        newDiv.className = "customDiv";
        $.get("https://jsonplaceholder.typicode.com/posts/2", (data, status) => {
            alert( JSON.stringify(data));
            newDiv.textContent = JSON.stringify(data);
        });  
        // Add some text content (optional)
        

        // Append the new div to an existing element in the DOM
        document.body.appendChild(newDiv);
    })();
