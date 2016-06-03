
function dropIt() {
    if ($(".dropdown_content").css("display") === "none") {
        $(".dropdown_content").css("display", "block");
    } else {
        $(".dropdown_content").css("display", "none");
    }
    $(document).mouseup(function (e) {
        var container = $(".dropdown_content");

        if (!container.is(e.target) // if the target of the click isn't the container...
            && container.has(e.target).length === 0) // ... nor a descendant of the container
        {
            container.css("display","none");
        }
    });

}