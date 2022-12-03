window.onscroll = function () { myFunction() };

function myFunction() {
    var winScrollTop = document.body.scrollTop || document.documentElement.scrollTop;
    var height = document.body.scrollHeight - document.body.clientHeight;
    var scrolled = (winScrollTop / (height)) * 100;
    document.getElementById("myBar").style.width = scrolled + "%";

    // var navbar = document.getElementById("header");
    // var sticky = navbar.offsetTop;
    // if (window.pageYOffset >= sticky) {
    //     navbar.classList.add("sticky")
    // } else {
    //     navbar.classList.remove("sticky");
    // }
}
