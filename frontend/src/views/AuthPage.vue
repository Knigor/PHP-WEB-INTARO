<template>
  <div class="flex items-center justify-center h-screen">
    <form v-if="isVisible" class="w-96 space-y-6" @submit="onSubmit">
      <FormField v-slot="{ componentField: usernameField }" name="username">
        <FormItem>
          <FormLabel>Введите ФИО</FormLabel>
          <FormControl>
            <Input
              type="text"
              v-model="fioValue"
              placeholder="Введите ваше ФИО"
              v-bind="usernameField"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
      <FormField v-slot="{ componentField: emailField }" name="email">
        <FormItem>
          <FormLabel>Введите ваш email</FormLabel>
          <FormControl>
            <Input
              type="text"
              v-model="emailValue"
              placeholder="Введите ваш email"
              v-bind="emailField"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>

      <FormField v-slot="{ componentField: phoneField }" name="phone">
        <FormItem>
          <FormLabel>Введите ваш номер телефона</FormLabel>
          <FormControl>
            <Input
              type="text"
              v-model="phoneValue"
              placeholder="+7 (800) 555 35 35"
              v-bind="phoneField"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>
      <FormField v-slot="{ componentField: textAreaField }" name="textArea">
        <FormItem>
          <FormLabel>Оставьте комментарий</FormLabel>
          <FormControl>
            <Textarea
              type="text"
              v-model="textValue"
              placeholder="Оставьте комментарий"
              v-bind="textAreaField"
            />
          </FormControl>
          <FormMessage />
        </FormItem>
      </FormField>

      <Button type="submit"> Отправить </Button>
    </form>
    <div v-else>
      <p class="text-gray-400">
        ФИО пользователя: <span class="text-black">{{ fioValue }}</span>
      </p>
      <p class="text-gray-400">
        Почта пользователя: <span class="text-black">{{ emailValue }}</span>
      </p>
      <p class="text-gray-400">
        Телефон: <span class="text-black">{{ phoneValue }}</span>
      </p>
      <p class="text-gray-400">
        Комментарий: <span class="text-black">{{ textValue }}</span>
      </p>
    </div>
  </div>
</template>

<script setup>
import { h } from 'vue'
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { Textarea } from '@/components/ui/textarea'
import { ref } from 'vue'
import { Terminal } from 'lucide-vue-next'
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert'

import { Button } from '@/components/ui/button'
import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage
} from '@/components/ui/form'
import { Input } from '@/components/ui/input'

const formSchema = toTypedSchema(
  z.object({
    username: z
      .string({ required_error: 'Поле не должно быть пустым' })
      .max(50, { message: 'Поле должно быть не больше 50 символов' })
      .regex(/^[^\d]*$/, { message: 'Поле не должно содержать цифры' })
      .regex(/([А-ЯЁ][а-яё]+[\-\s]?){3,}/, {
        message: 'Введите корректные данные'
      }),

    email: z
      .string({ required_error: 'Поле не должно быть пустым' })
      .email({ message: 'Неправильно введена почта' }),
    phone: z
      .string({ required_error: 'Поле не должно быть пустым' })
      .regex(/^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$/, {
        message: 'Введите корректный номер телефона'
      }),
    textArea: z.string({ required_error: 'Поле не должно быть пустым' })
  })
)

let phoneValue = ref('')
let fioValue = ref('')
let emailValue = ref('')
let textValue = ref('')

const { handleSubmit, errors } = useForm({
  validationSchema: formSchema
})

let isVisible = ref(true)

const onSubmit = handleSubmit((formData) => {
  const data = formData
  console.log(data)

  phoneValue.value = data.phone
  fioValue.value = data.username
  emailValue.value = data.email
  textValue.value = data.textArea

  isVisible.value = false
})
</script>

<style lang="scss" scoped></style>
