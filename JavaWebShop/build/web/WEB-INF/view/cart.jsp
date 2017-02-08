<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <c:set var='view' value='/cart' scope='session' />
        <div id="main">

            <div id="centerColumn">

                <c:choose>
                    <c:when test="${cart.numberOfItems > 1}">
                        <p>Your shopping cart contains ${cart.numberOfItems} items.</p>
                    </c:when>
                    <c:when test="${cart.numberOfItems == 1}">
                        <p>Your shopping cart contains ${cart.numberOfItems} item.</p>
                    </c:when>
                    <c:otherwise>
                        <p>Your shopping cart is empty.</p>
                    </c:otherwise>
                </c:choose>

                <div id="actionBar">
                    <%-- clear cart widget --%>
                    <c:if test="${!empty cart && cart.numberOfItems != 0}">
                        <c:url var="url" value="viewCart">
                            <c:param name="clear" value="true"/>
                        </c:url>
                        
                        <a href="${url}" class="bubble hMargin">Clear cart</a>
                    </c:if>

                    <%-- continue shopping widget --%>
                    <c:set var="value">
                        <c:choose>
                            <%-- if 'selectedCategory' session object exists, send user to previously viewed category --%>
                            <c:when test="${!empty selectedCategory}">
                                category
                            </c:when>
                            <%-- otherwise send user to welcome page --%>
                            <c:otherwise>
                                index.jsp
                            </c:otherwise>
                        </c:choose>
                    </c:set>

                    <a href="${value}" class="bubble hMargin">Continue shopping</a>

                    <%-- checkout widget --%>
                    <c:if test="${!empty cart && cart.numberOfItems != 0}">
                        <a href="checkout" class="bubble hMargin">Proceed to checkout &#x279f;</a>
                    </c:if>
                </div>
                    
                    <c:if test="${!empty cart && cart.numberOfItems != 0}">
                <h4 id="subtotal">Subtotal: ${cart.subtotal} &euro;</h4>

                <table id="cartTable">

                    <tr class="header">
                        <th>Product</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                    </tr>

                    <c:forEach var="cartItem" items="${cart.items}" varStatus="i">
                        <c:set var="Product" value="${cartItem.product}" />
                            <tr class="${((iter.index % 2) == 0) ? 'lightBlue' : 'white'}">
                                <td>
                                    <img src="${initParam.productsImagePath}${Product.name}.png"
                                         alt="${Product.name}">
                                </td>
                                <td>${Product.name}</td>
                                <td>
                                    ${cartItem.total} &euro; <br>
                                    <span class="smallText">${Product.price} &euro;</span>
                                </td>
                                <td>
                                    <form action="updateCart" method="post">
                                        <input type="hidden"
                                               name="productId"
                                               value="${Product.id}">
                                        <input type="text"
                                               maxlength="2"
                                               size="2"
                                               value="${cartItem.quantity}"
                                               name="quantity">
                                        <input type="submit"
                                               name="submit"
                                               value="update button">
                                    </form>
                                </td>
                            </tr>
                    </c:forEach>
                </table>
                        </c:if>
            </div>
        </div>
    </body>
</html>