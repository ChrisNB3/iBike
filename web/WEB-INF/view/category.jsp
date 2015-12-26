<%--
    Document   : category
    Created on : May 21, 2010, 12:20:23 AM
    Author     : tgiunipero
--%>

<%-- Set session-scoped variable to track the view user is coming from.
     This is used by the language mechanism in the Controller so that
     users view the same page when switching between English and Czech. --%>
<c:set var='view' value='/category' scope='session' />

<div id="categoryLeftColumn">

    <c:forEach var="category" items="${categories}">

        <c:choose>
            <c:when test="${category.name == selectedCategory.name}">
                <div class="categoryButton" id="selectedCategory">
                    <span class="categoryText">
                        <fmt:message key='${category.name}'/>
                    </span>
                </div>
            </c:when>
            <c:otherwise>
                <%--<a href="category?${category.id}" class="categoryButton">--%>
                <a href="<c:url value='category?${category.id}'/>" class="categoryButton">
                    <span class="categoryText">
                        <fmt:message key='${category.name}'/>
                    </span>
                </a>
            </c:otherwise>
        </c:choose>

    </c:forEach>

</div>

<div id="categoryRightColumn">

    <p id="categoryTitle"><fmt:message key='${selectedCategory.name}'/></p>

    <table id="productTable">

        <c:forEach var="product" items="${categoryProducts}" varStatus="iter">

            <tr class="${((iter.index % 2) == 0) ? 'lightBlue' : 'white'}">
                <td>
                    <img src="${initParam.productImagePath}${product.name}.png"
                         alt="<fmt:message key='${product.name}'/>">
                </td>

                <td>
                    <fmt:message key='${product.name}'/>
                    <br>
                    <span class="smallText"><fmt:message key='${product.name}Description'/></span>
                </td>

                <td><fmt:formatNumber type="currency" currencySymbol="&euro; " value="${product.price}"/></td>

                <td style="width:340px">
                    <!--<form action="addToCart" method="post">-->
                    <form action="<c:url value='addToCart'/>" method="post">
                        <select name="selectedSizeId">
                          <c:forEach var="size" items="${sizes}">
                            <option value="${size.id}"
                                <c:if test="${param.productId eq product.id and param.selectedSizeId eq size.id}">selected</c:if>><fmt:message key='${size.name}'/></option>
                          </c:forEach>
                        </select>
                        <select name="selectedColorId">
                          <c:forEach var="color" items="${colors}">
                            <option value="${color.id}"
                                <c:if test="${param.productId eq product.id and param.selectedColorId eq color.id}">selected</c:if>><fmt:message key='${color.name}'/></option>
                          </c:forEach>
                        </select>
                        <input type="hidden"
                               name="productId"
                               value="${product.id}">
                        <input type="submit"
                               name="submit"
                               value="add to cart">
                    </form>
                </td>
            </tr>

        </c:forEach>

    </table>
</div>