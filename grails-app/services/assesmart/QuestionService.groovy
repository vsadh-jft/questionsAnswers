package assesmart

import com.assesmart.enumeration.QuestionType
import com.assesmart.question.Answer
import com.assesmart.question.ItemBank
import com.assesmart.question.Question
import grails.transaction.Transactional

@Transactional
class QuestionService {

    public Integer createUpdateMultipleChoiceQuestion(List answers,Integer correctAnswer,Integer itemBank,Long id,String description) {
        Question question = new Question();
        if(id!=null && id>0){
            question = Question.get(id)
        }
        question.setDescription(description)
        question.setItemBank(ItemBank.get(itemBank))
        question.setId(id)
        question.setQuestionType(QuestionType.MULTIPLE_CHOICE)
        List<Answer> answersList = new LinkedList<Answer>();
        for(String s:answers){
            Answer answer =new Answer();
            answer.setAnswer(s)
            answer.setCorrectAnswer(answers.get(correctAnswer-1).equals(s)?true:false)
            answer.setQuestion(question)
            answersList.add(answer)
        }
        if(question?.id>0){
            Answer.findAllByQuestion(Question.get(question.id)).each {it.delete()}
        }
        question.setAnswers(answersList)
        question.save(flush: true, failOnError: true)
        return question.id
    }

    public Integer createUpdateMultipleSelectQuestion(List answers,List correctAnswers,Integer itemBank,Long id,String description) {
        Question question = new Question();
        if(id!=null && id>0){
            question = Question.get(id)
        }
        question.setDescription(description)
        question.setItemBank(ItemBank.get(itemBank))
        question.setId(id)
        question.setQuestionType(QuestionType.MULTIPLE_SELECT)
        List<Answer> answersList = new LinkedList<Answer>();
        int i =1;
        for(String s:answers){
            Answer answer =new Answer();
            answer.setAnswer(s)
            answer.setCorrectAnswer(correctAnswers.toArray().contains(i.toString())?true:false)
            answer.setQuestion(question)
            answersList.add(answer)
            i++;
        }
        if(question?.id>0){
            Answer.findAllByQuestion(question).each {it.delete()}
        }
        question.setAnswers(answersList)
        question.save(flush: true, failOnError: true)
        return question.id
    }

    public Integer createUpdateEssayQuestion(Integer itemBank,Long id,String description,Integer height){
        Question question = new Question();
        if(id!=null && id>0){
            question = Question.get(id)
        }
        question.setDescription(description)
        question.setItemBank(ItemBank.get(itemBank))
        question.setId(id)
        question.setQuestionType(QuestionType.ESSAY)
        question.setHeight(height)

        question.save(flush: true, failOnError: true)
        return question.id
    }

    public Integer createUpdateSingleResponseQuestion(List answers,Integer itemBank,Long id,String description,Integer points){
        Question question = new Question();
        if(id!=null && id>0){
            question = Question.get(id)
        }
        question.setDescription(description)
        question.setItemBank(ItemBank.get(itemBank))
        question.setPoints(points)
        question.setId(id)
        question.setQuestionType(QuestionType.SINGLE_RESPONSE)
        List<Answer> answersList = new LinkedList<Answer>();
        for(String s:answers){
            Answer answer =new Answer();
            answer.setAnswer(s)
            answer.setQuestion(question)
            answersList.add(answer)
        }
        if(question?.id>0){
            Answer.findAllByQuestion(question).each {it.delete()}
        }
        question.setAnswers(answersList)
        question.save(flush: true, failOnError: true)
        return question.id

    }

    public Integer createFillTheBlankQuestion(Integer itemBank,Long id,String description){
        Question question = new Question();
        if(id!=null && id>0){
            question = Question.get(id)
        }
        question.setDescription(description)
        question.setItemBank(ItemBank.get(itemBank))
        question.setId(id)
        question.setQuestionType(QuestionType.FILL_IN_THE_BLANKS)
        question.save(flush: true, failOnError: true)
        return question.id
    }

    public Integer createReorderQuestion(List answers,List orders,Integer itemBank,Long id,String description){
        Question question = new Question();
        if(id!=null && id>0){
            question = Question.get(id)
        }
        question.setDescription(description)
        question.setItemBank(ItemBank.get(itemBank))
        question.setId(id)
        question.setQuestionType(QuestionType.REORDER)
        List<Answer> answersList = new LinkedList<Answer>();
        for(int i=0;i<answers.size();i++){
            Answer answer =new Answer();
            answer.setAnswer(answers.get(i))
            answer.setPrecedence(Integer.valueOf(orders.get(i)))
            answer.setQuestion(question)
            answersList.add(answer)
        }
        if(question?.id>0){
            Answer.findAllByQuestion(question).each {it.delete()}
        }
        question.setAnswers(answersList)
        question.save(flush: true, failOnError: true)
        return question.id
    }

    public Integer createMatchingQuestion(List sources,List destinations,List links,Integer itemBank,Long id,String description){
        Question question = new Question();
        if(id!=null && id>0){
            question = Question.get(id)
        }
        question.setDescription(description)
        question.setItemBank(ItemBank.get(itemBank))
        question.setId(id)
        question.setQuestionType(QuestionType.MATCHING)
        List<Answer> answersList = new LinkedList<Answer>();
        for(int i=0;i<sources.size();i++){
            Answer answer =new Answer();
            answer.setAnswer(sources.get(i))
            answer.setDestinationId(Integer.valueOf(links.get(i)))
            answer.setIndexNumber(i+1)
            answer.setQuestion(question)
            answersList.add(answer)
        }
        for(int i=0;i<destinations.size();i++){
            Answer answer =new Answer();
            answer.setAnswer(destinations.get(i))
            answer.setIndexNumber(i+1)
            answer.setQuestion(question)
            answersList.add(answer)
        }
        if(question?.id>0){
            Answer.findAllByQuestion(question).each {it.delete()}
        }
        question.setAnswers(answersList)
        question.save(flush: true, failOnError: true)
        return question.id
    }
}
