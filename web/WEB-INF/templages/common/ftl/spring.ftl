<#ftl strip_whitespace=true>

<#--
 * message as m
 *
 * Macro to translate a message code into a message.
 -->
<#macro m code>${springMacroRequestContext.getMessage(code)}</#macro>

<#--
 * messageText as mt
 *
 * Macro to translate a message code into a message,
 * using the given default text if no message found.
 -->
<#macro mt code, text>${springMacroRequestContext.getMessage(code, text)}</#macro>

<#--
 * messageArgs as ma
 *
 * Macro to translate a message code with arguments into a message.
 -->
<#macro ma code, args>${springMacroRequestContext.getMessage(code, args)}</#macro>

<#--
 * messageArgsText as mat
 *
 * Macro to translate a message code with arguments into a message,
 * using the given default text if no message found.
 -->
<#macro mat code, args, text>${springMacroRequestContext.getMessage(code, args, text)}</#macro>

<#--
 * theme
 *
 * Macro to translate a theme message code into a message.
 -->
<#macro theme code>${springMacroRequestContext.getThemeMessage(code)}</#macro>

<#--
 * themeText
 *
 * Macro to translate a theme message code into a message,
 * using the given default text if no message found.
 -->
<#macro themeText code, text>${springMacroRequestContext.getThemeMessage(code, text)}</#macro>

<#--
 * themeArgs
 *
 * Macro to translate a theme message code with arguments into a message.
 -->
<#macro themeArgs code, args>${springMacroRequestContext.getThemeMessage(code, args)}</#macro>

<#--
 * themeArgsText
 *
 * Macro to translate a theme message code with arguments into a message,
 * using the given default text if no message found.
 -->
<#macro themeArgsText code, args, text>${springMacroRequestContext.getThemeMessage(code, args, text)}</#macro>


<#--
 * bind
 *
 * Exposes a BindStatus object for the given bind path, which can be
 * a bean (e.g. "person") to get global errors, or a bean property
 * (e.g. "person.name") to get field errors. Can be called multiple times
 * within a form to bind to multiple command objects and/or field names.
 *
 * This macro will participate in the default HTML escape setting for the given
 * RequestContext. This can be customized by calling "setDefaultHtmlEscape"
 * on the "springMacroRequestContext" context variable, or via the
 * "defaultHtmlEscape" context-param in web.xml (same as for the JSP bind tag).
 * Also regards a "htmlEscape" variable in the namespace of this library.
 *
 * Producing no output, the following context variable will be available
 * each time this macro is referenced (assuming you import this library in
 * your templates with the namespace 'spring'):
 *
 *   spring.status : a BindStatus instance holding the command object name,
 *   expression, value, and error messages and codes for the path supplied
 *
 * @param path : the path (string value) of the value required to bind to.
 *   Spring defaults to a command name of "command" but this can be overridden
 *   by user config.
 -->
<#macro bind path>
    <#if htmlEscape?exists>
        <#assign status = springMacroRequestContext.getBindStatus(path, htmlEscape)>
    <#else>
        <#assign status = springMacroRequestContext.getBindStatus(path)>
    </#if>
    <#-- assign a temporary value, forcing a string representation for any
    kind of variable. This temp value is only used in this macro lib -->
    <#if status.value?exists && status.value?is_boolean>
        <#assign stringStatusValue=status.value?string>
    <#else>
        <#assign stringStatusValue=status.value?default("")>
    </#if>
</#macro>

<#--
 * bindEscaped
 *
 * Similar to spring:bind, but takes an explicit HTML escape flag rather
 * than relying on the default HTML escape setting.
 -->
<#macro bindEscaped path, htmlEscape>
    <#assign status = springMacroRequestContext.getBindStatus(path, htmlEscape)>
    <#-- assign a temporary value, forcing a string representation for any
    kind of variable. This temp value is only used in this macro lib -->
    <#if status.value?exists && status.value?is_boolean>
        <#assign stringStatusValue=status.value?string>
    <#else>
        <#assign stringStatusValue=status.value?default("")>
    </#if>
</#macro>
