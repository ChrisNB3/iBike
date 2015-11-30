<%--
    Document   : checkout
    Author     : Nicolas Barthelemy
--%>


<%-- Set session-scoped variable to track the view user is coming from.
     This is used by the language mechanism in the Controller so that
     users view the same page when switching between English and Czech. --%>
<c:set var='view' value='/checkout' scope='session' />

<script src="js/jquery.validate.js" type="text/javascript"></script>

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

<div id="singleColumn">

    <h2><fmt:message key="checkout"/></h2>

    <p><fmt:message key="checkoutText"/></p>

    <c:if test="${!empty orderFailureFlag}">
        <p class="error"><fmt:message key="orderFailureError"/></p>
    </c:if>

    <!--<form action="purchase" method="post">-->
    <form id="checkoutForm" action="<c:url value='purchase'/>" method="post">
        <table id="checkoutTable">
          <c:if test="${!empty validationErrorFlag}">
            <tr>
                <td colspan="2" style="text-align:left">
                    <span class="error smallText"><fmt:message key='validationErrorMessage'/>

                      <c:if test="${!empty nameError}">
                        <br><span class="indent"><fmt:message key='nameError'/></span>
                      </c:if>
                      <c:if test="${!empty emailError}">
                        <br><span class="indent"><fmt:message key='emailError'/></span>
                      </c:if>
                      <c:if test="${!empty phoneError}">
                        <br><span class="indent"><fmt:message key='phoneError'/></span>
                      </c:if>
                      <c:if test="${!empty addressError}">
                        <br><span class="indent"><fmt:message key='addressError'/></span>
                      </c:if>
                      <c:if test="${!empty departmentError}">
                        <br><span class="indent"><fmt:message key='departmentError'/></span>
                      </c:if>
                      <c:if test="${!empty ccNumberError}">
                        <br><span class="indent"><fmt:message key='ccNumberError'/></span>
                      </c:if>

                    </span>
                </td>
            </tr>
          </c:if>
            <tr>
                <td><label for="delivery"><fmt:message key="delivery"/>:</label>
                    <c:if test="${cart.delivery}">
                        <fmt:message key='yes'/></c:if>
                    <c:if test="${not cart.delivery}">
                        <fmt:message key='no'/></c:if>  
                </td>
                <td>
                    <c:if test="${cart.delivery}">
                        <c:url var="url" value="toggleDelivery">
                            <c:param name="delivery" value="false"/>
                        </c:url>
                        <div class="toggleDelivery"><a href="${url}"><fmt:message key='wantNoDelivery'/></a></div>
                    </c:if>
                    <c:if test="${not cart.delivery}">
                        <c:url var="url" value="toggleDelivery">
                            <c:param name="delivery" value="true"/>
                        </c:url>
                        <div class="toggleDelivery"><a href="${url}"><fmt:message key='wantDelivery'/></a></div>
                    </c:if>  
                    
                </td>
            </tr>
            <tr>
                <td><label for="name"><fmt:message key="customerName"/>:</label></td>
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
                <td><label for="email"><fmt:message key="email"/>:</label></td>
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
                <td><label for="phone"><fmt:message key="phone"/>:</label></td>
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
                <td><label for="address"><fmt:message key="address"/>:</label></td>
                <td class="inputField">
                    <input type="text"
                           size="31"
                           maxlength="45"
                           id="address"
                           name="address"
                           value="${param.address}">

                    <br>
                    <fmt:message key="department"/>
                    <select name="department">
                      <c:forEach begin="1" end="96" var="departmentNumber">
                        <option value="${departmentNumber}"
                                <c:if test="${param.department eq departmentNumber}">selected</c:if>>${departmentNumber}</option>
                      </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="creditcard"><fmt:message key="creditCard"/>:</label></td>
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
                    <input type="submit" value="<fmt:message key='submit'/>">
                </td>
            </tr>
        </table>
    </form>

    <div id="infoBox">

        <ul>
            <li><fmt:message key="deliveryTimeGuarantee"/></li>
            <li><fmt:message key="deliveryFee1"/>
                <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${initParam.deliverySurcharge}"/>
                <fmt:message key="deliveryFee2"/></li>
            <li><fmt:message key="discountOffer1"/>
                ${initParam.discountNumberProducts}
                <fmt:message key="discountOffer2"/>
                ${initParam.discountValue}
                <fmt:message key="discountOffer3"/></li>
        </ul>

        <table id="priceBox">
            <tr>
                <td><fmt:message key="subtotal"/>:</td>
                <td class="checkoutPriceColumn">
                    <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${cart.subtotal}"/></td>
            </tr>
            <tr>
                <td><fmt:message key="surcharge"/>:</td>
                <td class="checkoutPriceColumn">
                    <c:if test="${cart.delivery}">
                        <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${initParam.deliverySurcharge}"/></c:if>
                    <c:if test="${not cart.delivery}">
                        <fmt:formatNumber type="currency" currencySymbol="&euro; " value="0"/></c:if>
                </td>
            </tr>
            <c:if test="${!empty cart && cart.numberOfItems != 0 && cart.discount ne 0.0 }">
                <tr>
                    <td><fmt:message key="discount"/>:</td>
                    <td class="checkoutPriceColumn" style="color: #f00">
                        ${initParam.discountValue} %
                    </td>
                </tr>
            </c:if>
            <tr>
                <td class="total"><fmt:message key="total"/>:</td>
                <td class="total checkoutPriceColumn">
                    <fmt:formatNumber type="currency" currencySymbol="&euro; " value="${cart.total}"/></td>
            </tr>
        </table>
    </div>
</div>