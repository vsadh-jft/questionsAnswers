<g:if test="${questionInstance?.id>0}">
    <g:set var="i" value="${0}"/>
    <g:set var="count" value="${questionInstance.answers.size()}"/>
    <g:each in="${questionInstance.answers}" var="answerInstance">
        <div name="parent">
            <div id="Create_${i}" class="fieldcontain ${hasErrors(bean: answerInstance, field: 'answer', 'error')} ">
                <label for="answer">
                    <g:message code="answer.answer.label" default="Answer ${i + 1}" />
                </label>
                <g:textField name="answer" required="required" value="${answerInstance?.answer}"/>
                <label for="correctAnswer">
                    <g:message code="answer.correctAnswer.label" default="Correct Answer" />
                </label>
                <g:checkBox name="correctAnswer" checked="${answerInstance?.correctAnswer}" value="${i + 1}" />
                <g:if test="${count-1==i}">
                    <a href="#" class="removeLink" onclick="removeOption('${'Create_' + i}',false)" ><g:message code="question.answer.remove" /></a>
                </g:if>
            </div>
        </div>
        <g:set var="i" value="${i+1}"/>
    </g:each>
</g:if>
<g:else>
    <div name="parent">
        <div id="Create_${answerIndex}" class="fieldcontain ${hasErrors(bean: answerInstance, field: 'answer', 'error')} ">
            <label for="answer">
                <g:message code="answer.answer.label" default="Answer ${Integer.valueOf(answerIndex) + 1}" />
            </label>
            <g:textField name="answer" required="required" value="${answerInstance?.answer}"/>
            <label for="correctAnswer">
                <g:message code="answer.correctAnswer.label" default="Correct Answer" />
            </label>
            <g:checkBox name="correctAnswer" value="${Integer.valueOf(answerIndex) + 1}" />
            <a href="#" class="removeLink" onclick="removeOption( '${'Create_' + answerIndex}',true)" ><g:message code="question.answer.remove" /></a>
        </div>
    </div>
</g:else>






