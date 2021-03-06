<%@ page import="com.assesmart.question.ItemBank; com.assesmart.question.Question;com.assesmart.enumeration.QuestionType" %>
<div class="multi-form">
<div class="desc">
    <h3><g:message code="question.description.label"/> </h3>
    <g:textField name="description" class="text1" required="" value="${questionInstance?.description}"/>
</div>
    <g:if test="${itemBankId}">
        <div class="itm-bnk">
        <g:hiddenField name="itemBank.id" value="${itemBankId}" />
        <h3><g:message code="question.itemBank.label" /> </h3>
            <h3 style="margin-left: 3%">${ItemBank.get(itemBankId).name}</h3>
        </div>
    </g:if>
    <g:else>
        <div class="itm-bnk">
            <h3><g:message code="question.itemBank.label" /></h3>
            <div class="select2">
                <g:select id="itemBank" class="select2" name="itemBank.id" from="${com.assesmart.question.ItemBank.list()}" optionKey="id" required="" value="${questionInstance?.itemBank?.id}" />
                <script type="text/javascript">
                    $(function () {
                        $("#itemBank").selectbox();
                    });
                </script>
            </div>
        </div>
    </g:else>

<g:hiddenField name="questionType" value="${questionType!=null?questionType:questionInstance.questionType}" />
<g:if test="${questionInstance?.id>0}">
    <g:set var="questionType" value="${questionInstance.questionType.toString()}"></g:set>
</g:if>
<g:if test="${questionType==QuestionType.MULTIPLE_CHOICE.toString()}">
    <div id="multichoice">
        <g:render template="mutipleChoice" model="[answerIndex:0]"/>
    </div>
    <div class="add-ans">
        <a href="#" onclick="addAnswer('${questionType}');"><span>(<g:message code="question.answer.add.label" />)</span></a>
    </div>

</g:if>
<g:elseif test="${questionType==QuestionType.MULTIPLE_SELECT.toString()}">
    <div id="multipleSelect">
        <g:render template="multipleSelect" model="[answerIndex:0]" />
    </div>
    <div class="add-ans">
        <a href="#" onclick="addAnswer('${questionType}');"><span>(<g:message code="question.answer.add.label" />)</span></a>
    </div>
</g:elseif>
<g:elseif test="${questionType==QuestionType.ESSAY.toString()}">
    <div id="essay">
        <g:render template="essay" model="[answerIndex:0]" />
    </div>
</g:elseif>
<g:elseif test="${questionType==QuestionType.SINGLE_RESPONSE.toString()}">
    <div id="singleResponse">
        <g:render template="singleResponse" model="[answerIndex:0]" />
    </div>
    <div class="add-ans">
        <a href="#" onclick="addAnswer('${questionType}');"><span>(<g:message code="question.answer.add.label" />)</span></a>
    </div>
    <div class="points">
        <h3><g:message code="question.answer.point.label"/> </h3>
        <input type="number" name="points" min="1" max=""  value="${questionInstance?.points}" class="quant">
    </div>

</g:elseif>
<g:elseif test="${questionType==QuestionType.REORDER.toString()}">
    <div id="reorder">
        <g:render template="reorder" model="[answerIndex:0]" />
    </div>
    <div class="add-ans">
        <a href="#" onclick="addAnswer('${questionType}');"><span>(<g:message code="question.answer.add.label" />)</span></a>
    </div>
</g:elseif>
<g:elseif test="${questionType==QuestionType.MATCHING.toString()}">
    <div id="match" class="match">
        <h3><g:message code="question.answer.source"/> </h3>
        <h4><g:message code="question.answer.destination" /></h4>
        <g:render template="match" model="[answerIndex:0,sources:sources,destinations:destinations]" />
    </div>
    <div class="add-ans">
        <a href="#" onclick="addAnswer('${questionType}');"><span>(<g:message code="question.answer.add.label" />)</span></a>
    </div>
</g:elseif>
</div>
<script type="text/javascript">

    function addAnswer(questionType) {
        $('.remove-box').remove();
        var links = document.getElementsByClassName('removeLink');
        var i = document.getElementsByName("answer").length;
        $.ajax({
            url: '${createLink(controller: 'question', action: 'addAnswer')}',
            data: {answerIndex: i,questionType:questionType},
            cache: false,
            success: function(html) {
                if(questionType=='MULTIPLE_CHOICE'){
                    $('div[id="multichoice"]').append(html);
                }else if(questionType=='MULTIPLE_SELECT'){
                    $('div[id="multipleSelect"]').append(html);
                }else if(questionType=='SINGLE_RESPONSE'){
                    $('div[id="singleResponse"]').append(html);
                }else if(questionType=='REORDER'){
                    $('div[id="reorder"]').append(html);
                    }else if(questionType=='MATCHING'){
                    $('div[id="match"]').append(html);
                }

            }
        });
    }

    function removeOption(id,isCreate){
        var i = document.getElementsByName("answer").length;
        i=i-2
        var j = document.getElementsByClassName("ans").length;
        j=j-2
        console.debug(j)
        console.debug(i)
        if(isCreate && i>=1){
            $(".ans:eq(" + j + ")").append("<div class=remove-box> <a href=# class=removeLink onclick=removeOption(" + "'" + 'Create_' + i +  "'"  + ",true" + ")><img src='${resource(dir: 'images', file: 'Remove-icon.png')}' ><span><g:message code="question.answer.remove" /></span></a> </div>");
        }else if(!isCreate && i>=1){
            $(".ans:eq(" + j + ")").append("<div class=remove-box> <a href=# class=removeLink onclick=removeOption(" + "'" + 'Create_' + i +  "'"  + ",false" + ")><img src='${resource(dir: 'images', file: 'Remove-icon.png')}' ><span><g:message code="question.answer.remove" /></span></a> </div>");
        }
        if(i>=0){
            return (elem=document.getElementById(id)).parentNode.removeChild(elem);
        }
    }

</script>
