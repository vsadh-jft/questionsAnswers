package com.assesmart.assesment

class General {

    Boolean isStrictMode

    Boolean isAllowChangeLanguage

    Boolean isSendMail

    Integer timeLimit

    Boolean isHidePauseButton

    Integer autoSubmitTimeLimit

    String noContinuationText

    Boolean isTotalScore

    Boolean isVariableScore

    Double passMark

    String admittedURL

    Boolean isDisableURLSecurity

    String externalResources

    static belongsTo = [assessment: Assessment]

    static constraints = {
        timeLimit nullable: true
        autoSubmitTimeLimit nullable: true
        noContinuationText nullable: true
        passMark nullable: true
        admittedURL nullable: true, blank: false
        externalResources nullable: true, blank: false
    }
}
