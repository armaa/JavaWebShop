<%--
    Document   : confirmation
    Created on : Sep 9, 2009, 12:20:30 AM
    Author     : tgiunipero
--%>

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
        <div id="main">
            <div id="singleColumn">

                <p id="confirmationText">
                    <strong>Your order has been successfully processed and will be delivered within 24 hours.</strong>
                    <br><br>
                    Please keep a note of your confirmation number:
                    <strong>${orderRecord.confirmationNumber}</strong>
                    <br>
                    If you have a query concerning your order, feel free to <a href="mailto:armin.bodruzic@gmail.com">contact us</a>.
                    <br><br>
                    Thank you for shopping at the Java Web Shop Shop!
                </p>

                <div class="summaryColumn" >
                    <table id="orderSummaryTable" class="detailsTable">
                        <tr class="header">
                            <th colspan="3">Order summary</th>
                        </tr>

                        <tr class="tableHeading">
                            <td>Product</td>
                            <td>Quantity</td>
                            <td>Price</td>
                        </tr>

                        <c:forEach var="orderedProduct" items="${orderedProducts}" varStatus="i">

                            <tr class="${((i.index % 2) != 0) ? 'lightBlue' : 'white'}">
                                <td>
                                    ${products[i.index].name}
                                </td>
                                <td class="quantityColumn">
                                    ${orderedProduct.quantity}
                                </td>
                                <td class="confirmationPriceColumn">
                                    ${products[i.index].price * orderedProduct.quantity} &euro;
                                </td>
                            </tr>

                        </c:forEach>

                        <tr class="lightBlue"><td colspan="3" style="padding: 0 20px"><hr></td></tr>

                        <tr class="lightBlue">
                            <td colspan="2" id="deliverySurchargeCellLeft"><strong>Delivery surcharge:</strong></td>
                            <td id="deliverySurchargeCellRight">${initParam.deliverySurcharge} &euro;</td>
                        </tr>

                        <tr class="lightBlue">
                            <td colspan="2" id="totalCellLeft"><strong>Total:</strong></td>
                            <td id="totalCellRight">${orderRecord.amount} &euro;</td>
                        </tr>

                        <tr class="lightBlue"><td colspan="3" style="padding: 0 20px"><hr></td></tr>

                        <tr class="lightBlue">
                            <td colspan="3" id="dateProcessedRow"><strong>Date processed:</strong>
                                ${orderRecord.dateCreated}
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="summaryColumn" >
                    <table id="deliveryAddressTable" class="detailsTable">
                        <tr class="header">
                            <th colspan="3">Delivery address</th>
                        </tr>

                        <tr>
                            <td colspan="3" class="lightBlue">
                                ${customer.name}
                                <br>
                                ${customer.address}
                                <br>
                                Prague ${customer.cityRegion}
                                <br>
                                <hr>
                                <strong>Email:</strong> ${customer.email}
                                <br>
                                <strong>Phone:</strong> ${customer.phone}
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>