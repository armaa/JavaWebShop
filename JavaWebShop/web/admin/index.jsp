<%-- 
    Document   : index
    Created on : 30.01.2017., 12:10:26
    Author     : office
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="adminMenu" class="alignLeft">
            <p><a href="<c:url value='viewCustomers'/>">View all customers</a></p>

            <p><a href="<c:url value='viewOrders'/>">View all orders</a></p>

            <p><a href="<c:url value='logout'/>">Log out</a></p>
        </div>

        <%-- customerList is requested --%>
        <c:if test="${!empty customerList}">

            <table id="adminTable" class="detailsTable">

                <tr class="header">
                    <th colspan="4">Customers</th>
                </tr>

                <tr class="tableHeading">
                    <td>Customer id</td>
                    <td>Name</td>
                    <td>Email</td>
                    <td>Phone</td>
                </tr>

                <c:forEach var="Customer" items="${customerList}" varStatus="i">

                    <tr class="${((i.index % 2) == 1) ? 'lightBlue' : 'white'} tableRow"
                        onclick="document.location.href='customerRecord?${Customer.id}'">

                      <%-- Below anchor tags are provided in case JavaScript is disabled --%>
                        <td><a href="customerRecord?${Customer.id}" class="noDecoration">${Customer.id}</a></td>
                        <td><a href="customerRecord?${Customer.id}" class="noDecoration">${Customer.name}</a></td>
                        <td><a href="customerRecord?${Customer.id}" class="noDecoration">${Customer.email}</a></td>
                        <td><a href="customerRecord?${Customer.id}" class="noDecoration">${Customer.phone}</a></td>
                    </tr>

                </c:forEach>

            </table>

        </c:if>

        <%-- orderList is requested --%>
        <c:if test="${!empty orderList}">

            <table id="adminTable" class="detailsTable">

                <tr class="header">
                    <th colspan="4">Orders</th>
                </tr>

                <tr class="tableHeading">
                    <td>Order id</td>
                    <td>Confirmation number</td>
                    <td>Amount</td>
                    <td>Date created</td>
                </tr>

                <c:forEach var="Order" items="${orderList}" varStatus="i">

                    <tr class="${((i.index % 2) == 1) ? 'lightBlue' : 'white'} tableRow"
                        onclick="document.location.href='orderRecord?${Order.id}'">

                      <%-- Below anchor tags are provided in case JavaScript is disabled --%>
                        <td><a href="orderRecord?${Order.id}" class="noDecoration">${Order.id}</a></td>
                        <td><a href="orderRecord?${Order.id}" class="noDecoration">${Order.confirmationNumber}</a></td>
                        <td><a href="orderRecord?${Order.id}" class="noDecoration">
                                <fmt:formatNumber type="currency"
                                                  currencySymbol="&euro; "
                                                  value="${Order.amount}"/></a></td>

                        <td><a href="orderRecord?${Order.id}" class="noDecoration">
                                <fmt:formatDate value="${Order.dateCreated}"
                                                type="both"
                                                dateStyle="short"
                                                timeStyle="short"/></a></td>
                    </tr>

                </c:forEach>

            </table>

        </c:if>

        <%-- customerRecord is requested --%>
        <c:if test="${!empty customerRecord}">

            <table id="adminTable" class="detailsTable">

                <tr class="header">
                    <th colspan="2">Customer details</th>
                </tr>
                <tr>
                    <td style="width: 290px"><strong>Customer id:</strong></td>
                    <td>${customerRecord.id}</td>
                </tr>
                <tr>
                    <td><strong>Name:</strong></td>
                    <td>${customerRecord.name}</td>
                </tr>
                <tr>
                    <td><strong>Email:</strong></td>
                    <td>${customerRecord.email}</td>
                </tr>
                <tr>
                    <td><strong>Phone:</strong></td>
                    <td>${customerRecord.phone}</td>
                </tr>
                <tr>
                    <td><strong>Address:</strong></td>
                    <td>${customerRecord.address}</td>
                </tr>
                <tr>
                    <td><strong>City region:</strong></td>
                    <td>${customerRecord.cityRegion}</td>
                </tr>
                <tr>
                    <td><strong>Credit card number:</strong></td>
                    <td>${customerRecord.ccNumber}</td>
                </tr>

                <tr><td colspan="2" style="padding: 0 20px"><hr></td></tr>

                <tr class="tableRow"
                    onclick="document.location.href='orderRecord?${order.id}'">
                    <td colspan="2">
                        <%-- Anchor tag is provided in case JavaScript is disabled --%>
                        <a href="orderRecord?${order.id}" class="noDecoration">
                        <strong>View order summary &#x279f;</strong></a></td>
                </tr>
            </table>

        </c:if>

        <%-- orderRecord is requested --%>
        <c:if test="${!empty orderRecord}">

            <table id="adminTable" class="detailsTable">

                <tr class="header">
                    <th colspan="2">Order summary</th>
                </tr>
                <tr>
                    <td><strong>Order id:</strong></td>
                    <td>${orderRecord.id}</td>
                </tr>
                <tr>
                    <td><strong>Confirmation number:</strong></td>
                    <td>${orderRecord.confirmationNumber}</td>
                </tr>
                <tr>
                    <td><strong>Date processed:</strong></td>
                    <td>
                        <fmt:formatDate value="${orderRecord.dateCreated}"
                                        type="both"
                                        dateStyle="short"
                                        timeStyle="short"/></td>
                </tr>

                <tr>
                    <td colspan="2">
                        <table class="embedded detailsTable">
                           <tr class="tableHeading">
                                <td class="rigidWidth">Product</td>
                                <td class="rigidWidth">Quantity</td>
                                <td>Price</td>
                            </tr>

                            <tr><td colspan="3" style="padding: 0 20px"><hr></td></tr>

                            <c:forEach var="orderedProduct" items="${orderedProducts}" varStatus="i">

                                <tr>
                                    <td>
                                        <fmt:message key="${products[i.index].name}"/>
                                    </td>
                                    <td>
                                        ${orderedProduct.quantity}
                                    </td>
                                    <td class="confirmationPriceColumn">
                                        <fmt:formatNumber type="currency" currencySymbol="&euro; "
                                                          value="${products[i.index].price * orderedProduct.quantity}"/>
                                    </td>
                                </tr>

                            </c:forEach>

                            <tr><td colspan="3" style="padding: 0 20px"><hr></td></tr>

                            <tr>
                                <td colspan="2" id="deliverySurchargeCellLeft"><strong>Delivery surcharge:</strong></td>
                                <td id="deliverySurchargeCellRight">
                                    <fmt:formatNumber type="currency"
                                                      currencySymbol="&euro; "
                                                      value="${initParam.deliverySurcharge}"/></td>
                            </tr>

                            <tr>
                                <td colspan="2" id="totalCellLeft"><strong>Total amount:</strong></td>
                                <td id="totalCellRight">
                                    <fmt:formatNumber type="currency"
                                                      currencySymbol="&euro; "
                                                      value="${orderRecord.amount}"/></td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr><td colspan="3" style="padding: 0 20px"><hr></td></tr>

                <tr class="tableRow"
                    onclick="document.location.href='customerRecord?${customer.id}'">
                    <td colspan="2">
                        <%-- Anchor tag is provided in case JavaScript is disabled --%>
                        <a href="customerRecord?${customer.id}" class="noDecoration">
                            <strong>View customer details &#x279f;</strong></a></td>
                </tr>
            </table>
        </c:if>
    </body>
</html>
