<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/affablebean.css">
        <title>Java Web Shop</title>
    </head>
    <body>
        <c:set var='view' value='/category' scope='session' />
        <div id="main">
            <div id="categoryLeftColumn">
                <c:forEach var="Category" items="${Categories}">
                    <c:choose>
                        <c:when test="${Category.name == selectedCategory.name}">
                            <div class="categoryButton" id="selectedCategory">
                                <div class="categoryText">
                                    <fmt:message key="${Category.name}" />
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="category?${Category.id}" class="categoryButton">
                                <span class="categoryText">
                                    <fmt:message key="${Category.name}" />
                                </span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <div id="categoryRightColumn">
                <table id="productTable">
                    <p id="categoryTitle"><fmt:message key="${selectedCategory.name}" /></p>
                    <c:forEach var="Product" items="${categoryProducts}" varStatus="i">
                        <tr class="${((i.index % 2) == 0) ? 'lightBlue' : 'white'}">
                            <td>
                                <img src="${initParam.productsImagePath}${Product.name}.png" alt="<fmt:message key="${Product.name}" />">
                            </td>
                            <td>
                                <fmt:message key="${Product.name}" />
                                <br>
                                <span class="smallText"><fmt:message key="${Product.description}" /></span>
                            </td>
                            <td>${Product.price} &euro;</td>
                            <td>
                                <form action="<c:url value='addToCart'/>"  method="post">
                                    <input type="hidden" name="productId" value="${Product.id}">
                                    <input type="submit" name="submit" value="<fmt:message key="Add to cart" />">
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </body>
</html>