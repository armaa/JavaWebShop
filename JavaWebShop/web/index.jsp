<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>


<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/affablebean.css">
    </head>
    <body>
        <c:set var='view' value='/index' scope='session' />
        <div id="main">
            <div id="indexLeftColumn">
                <div id="welcomeText">
                    <p style="font-size: larger"><fmt:message key="greeting" /></p>
                    <p><fmt:message key="introText" /></p>
                </div>
            </div>
            <div id="indexRightColumn">
                <c:forEach var="Category" items="${Categories}">
                    <div class="categoryBox">
                        <a class="nounderline" href="category?${Category.id}">
                            <span class="categoryLabelText"><fmt:message key="${Category.name}" /></span>
                            <img src="${initParam.categoryImagePath}${Category.name}.jpg">
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
