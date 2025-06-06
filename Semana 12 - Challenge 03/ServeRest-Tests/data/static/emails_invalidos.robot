*** Variables ***    #Todos e-mails que Violam o padrão RFC de formato de e-mail
@{emails_invalidos} 
...    abc
...    abc@
...    @teste.com
...    abc@.com
...    abc@com
...    abc@@teste.com
...    abc@teste..com
...    .abc@teste.com
...    abc.@teste.com
...    abc..def@teste.com
...    abc@-teste.com
...    abc@teste.com-
...    abc@.teste.com
...    abc@teste.com.
...    abc@te..ste.com
...    abc@teste@com
...    abc@ teste.com
...    abc test@teste.com
...    abc@teste .com
...    abc@tes*te.com
...    abc@%teste.com