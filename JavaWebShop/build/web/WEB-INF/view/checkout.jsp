<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/affablebean.css">
        <title>Java Web Shop</title>
        
        <script src="js/jquery.validate.js" type="text/javascript"></script>
        <script src="https://www.paypalobjects.com/api/checkout.js"></script>
        
        <script>
            paypal.Button.render({

                env: 'sandbox', // Optional: specify 'sandbox' environment
                
                client: {
                    sandbox: 'ARffLuACXvwhYJBbQ02C3au4Skn4UBq0O-08RxKA1v2wg8BhkKxE55YzzDVHE-b3G1rD2bn0Gjj3whyE'
                },
                
                payment: function() {

                    var env    = this.props.env;
                    var client = this.props.client;

                    return paypal.rest.payment.create(env, client, {
                        transactions: [
                            {
                                amount: { total: '${cart.total}', currency: 'EUR' }
                            }
                        ]
                    });
                },

                commit: true, // Optional: show a 'Pay Now' button in the checkout flow

                onAuthorize: function(data, actions) {

                    // Optional: display a confirmation page here

                    return actions.payment.execute().then(function() {
                        // Show a success page to the buyer
                    });
                }

            }, '#paypal-button');
        </script>



        <script type="text/javascript">

            $(document).ready(function(){
                $("#checkoutForm").validate({
                    rules: {
                        name: "required",
                        email: {
                            required: true,
                            email: true
                        },
                        phone: {
                            required: true,
                            number: true,
                            minlength: 9
                        },
                        address: {
                            required: true
                        },
                        creditcard: {
                            required: true,
                            creditcard: true
                        }
                    }
                });
            });
        </script>
    </head>
    <body>
        <c:set var='view' value='/checkout' scope='session' />
        <div id="main">

            <div id="centerColumn">

                <h2>Checkout</h2>

                <p>In order to purchase the items in your shopping cart, please provide us with the following information:</p>

                <c:if test="${!empty orderFailureFlag}">
                    <p class="error">We were unable to process your order. Please try again!</p>
                </c:if>

                <form id="checkoutForm" action="<c:url value='purchase'/>" method="post">
                    <table id="checkoutTable">
                      <c:if test="${!empty validationErrorFlag}">
                        <tr>
                            <td colspan="2" style="text-align:left">
                                <span class="error smallText">Please provide valid entries for the following field(s):

                                  <c:if test="${!empty nameError}">
                                    <br><span class="indent"><strong>Name</strong> (e.g., Bilbo Baggins)</span>
                                  </c:if>
                                  <c:if test="${!empty emailError}">
                                    <br><span class="indent"><strong>Email</strong> (e.g., b.baggins@hobbit.com)</span>
                                  </c:if>
                                  <c:if test="${!empty phoneError}">
                                    <br><span class="indent"><strong>Phone</strong> (e.g., 222333444)</span>
                                  </c:if>
                                  <c:if test="${!empty addressError}">
                                    <br><span class="indent"><strong>Address</strong> (e.g., Korunní 56)</span>
                                  </c:if>
                                  <c:if test="${!empty cityRegionError}">
                                    <br><span class="indent"><strong>City region</strong> (e.g., 2)</span>
                                  </c:if>
                                  <c:if test="${!empty ccNumberError}">
                                    <br><span class="indent"><strong>Credit card</strong> (e.g., 1111222233334444)</span>
                                  </c:if>
                                </span>
                            </td>
                        </tr>
                      </c:if>
                        <tr>
                            <td><label for="name">Name:</label></td>
                            <td class="inputField">
                                <input type="text"
                                       size="31"
                                       maxlength="45"
                                       id="name"
                                       name="name"
                                       value="${param.name}">
                            </td>
                        </tr>
                        <tr>
                            <td><label for="email">Email:</label></td>
                            <td class="inputField">
                                <input type="text"
                                       size="31"
                                       maxlength="45"
                                       id="email"
                                       name="email"
                                       value="${param.email}">
                            </td>
                        </tr>
                        <tr>
                            <td><label for="phone">Phone:</label></td>
                            <td class="inputField">
                                <input type="text"
                                       size="31"
                                       maxlength="16"
                                       id="phone"
                                       name="phone"
                                       value="${param.phone}">
                            </td>
                        </tr>
                        <tr>
                            <td><label for="address">Address:</label></td>
                            <td class="inputField">
                                <input type="text"
                                       size="31"
                                       maxlength="45"
                                       id="address"
                                       name="address"
                                       value="${param.address}">

                                <br>
                                Prague
                                <select name="cityRegion">
                                  <c:forEach begin="1" end="10" var="regionNumber">
                                    <option value="${regionNumber}"
                                            <c:if test="${param.cityRegion eq regionNumber}">selected</c:if>>${regionNumber}</option>
                                  </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="creditcard">Credit card number:</label></td>
                            <td class="inputField">
                                <input type="text"
                                       size="31"
                                       maxlength="19"
                                       id="creditcard"
                                       name="creditcard"
                                       value="${param.creditcard}">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="submit" value="submit purchase">
                            </td>
                        </tr>
                    </table>
                </form>

                <div id="infoBox">

                    <%--<div style="border: black solid 1px; height:100px; padding: 10px">
                        <ul>
                            <li>Next-day delivery is guaranteed</li>
                            <li>A &euro; ${initParam.deliverySurcharge}
                                delivery surcharge is applied to all purchase orders</li>
                        </ul>
                    </div> --%> 

                    <table id="priceBox">
                        <tr>
                            <td>Subtotal:</td>
                            <td class="checkoutPriceColumn">
                                ${cart.subtotal} &euro;</td>
                        </tr>
                        <tr>
                            <td>Delivery surcharge:</td>
                            <td class="checkoutPriceColumn">
                                ${initParam.deliverySurcharge} &euro;</td>
                        </tr>
                        <tr>
                            <td class="total">Total:</td>
                            <td class="total checkoutPriceColumn">
                                ${cart.total} &euro;</td>
                        </tr>
                        <div class="paypalButton" id="paypal-button"></div>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>