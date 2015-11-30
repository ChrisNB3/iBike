<%--
    Document   : confirmation
    Created on : Sep 9, 2009, 12:20:30 AM
    Author     : tgiunipero
--%>


<div id="singleColumn">
    
    <p id="confirmationText">
        <strong><fmt:message key="successMessage"/></strong>
        <br><br>
        <fmt:message key="confirmationNumberMessage"/>
        <strong>${orderRecord.confirmationNumber}</strong>
        <br>
        <fmt:message key="contactMessage"/>
        <br><br>
        <fmt:message key="thankYouMessage"/>
    </p>

    <table id="deliveryAddressTable" class="detailsTable">
        <tr class="header">
            <c:if test="${orderRecord.delivery}">
            <th colspan="3"><fmt:message key="deliveryAddress"/></th></c:if>
            <c:if test="${not orderRecord.delivery}">
            <th colspan="3"><fmt:message key="noDeliveryAddress"/></th></c:if>
        </tr>

        <tr>
            <td colspan="3" class="lightBlue">
                ${customer.name}
                <br>
                ${customer.address}
                <br>
                <fmt:message key="department"/>: ${customer.department}
                <br>
                <hr>
                <strong><fmt:message key="email"/>:</strong> ${customer.email}
                <br>
                <strong><fmt:message key="phone"/>:</strong> ${customer.phone}
            </td>
        </tr>
    </table>
        
    <!--<div class="summaryColumn" >-->
    <div>

        <table id="orderSummaryTable" class="detailsTable">
            <tr class="header">
                <th colspan="5"><fmt:message key="orderSummary"/></th>
            </tr>

            <tr class="tableHeading">
                <td><fmt:message key="product"/></td>
                <td><fmt:message key="color"/></td>
                <td><fmt:message key="size"/></td>
                <td><fmt:message key="quantity"/></td>
                <td><fmt:message key="price"/></td>
            </tr>

            <c:forEach var="orderedProduct" items="${orderedProducts}" varStatus="iter">

                <tr class="${((iter.index % 2) != 0) ? 'lightBlue' : 'white'}">
                    <td>
                        <fmt:message key="${products[iter.index].name}"/>
                    </td>
                    <td class="quantityColumn">
                        <fmt:message key="${orderedProductColors[iter.index].name}"/>
                    </td>
                    <td class="quantityColumn">
                        <fmt:message key="${orderedProductSizes[iter.index].name}"/>
                    </td>
                    <td class="quantityColumn">
                        ${orderedProduct.quantity}
                    </td>
                    <td class="confirmationPriceColumn">
                        <fmt:formatNumber type="currency" currencySymbol="&euro; "
                                          value="${products[iter.index].price * orderedProduct.quantity}"/>
                    </td>
                </tr>

            </c:forEach>

            <tr class="lightBlue"><td colspan="5" style="padding: 0 20px"><hr></td></tr>

            <c:if test="${orderRecord.delivery}">
                <tr class="lightBlue">
                    <td colspan="4" id="deliverySurchargeCellLeft"><strong><fmt:message key="surcharge"/>:</strong></td>
                    <td id="deliverySurchargeCellRight">
                        <fmt:formatNumber type="currency"
                                          currencySymbol="&euro; "
                                          value="${initParam.deliverySurcharge}"/></td>
                </tr>
            </c:if>
                
            <c:if test="${orderRecord.discount ne 0.0}">
                <tr class="lightBlue">
                    <td colspan="4" id="deliverySurchargeCellLeft"><strong><fmt:message key="discount"/>:</strong></td>
                    <td id="deliverySurchargeCellRight" style="color: #f00">
                        ${orderRecord.discount} %
                    </td>
                </tr>
            </c:if>
            
            <tr class="lightBlue">
                <td colspan="4" id="totalCellLeft"><strong><fmt:message key="total"/>:</strong></td>
                <td id="totalCellRight">
                    <fmt:formatNumber type="currency"
                                      currencySymbol="&euro; "
                                      value="${orderRecord.amount}"/></td>
            </tr>

            <tr class="lightBlue"><td colspan="5" style="padding: 0 20px"><hr></td></tr>

            <tr class="lightBlue">
                <td colspan="2"></td>
                <td colspan="3" id="dateProcessedRow"><strong><fmt:message key="dateProcessed"/>:</strong>
                    <fmt:formatDate value="${orderRecord.dateCreated}"
                                    type="both"
                                    dateStyle="short"
                                    timeStyle="short"/></td>
            </tr>
        </table>

    </div>

    
</div>