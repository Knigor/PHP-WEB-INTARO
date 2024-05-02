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
      <Toaster />
      <Button type="submit"> Отправить </Button>
    </form>

    <div class="flex flex-col items-start pl-2 pt-2 border-2 w-[400px] h-[200px]" v-else>
      <h1 class="font-semibold mb-4">Сообщение успешно отправлено</h1>
      <p class="text-gray-400">
        Фамилия: <span class="text-black">{{ lastNameValue }}</span>
      </p>
      <p class="text-gray-400">
        Имя: <span class="text-black">{{ firstNameValue }}</span>
      </p>
      <p class="text-gray-400">
        Отчество: <span class="text-black">{{ middleNameValue }}</span>
      </p>
      <p class="text-gray-400">
        Почта пользователя: <span class="text-black">{{ emailValue }}</span>
      </p>
      <p class="text-gray-400">
        Телефон: <span class="text-black">{{ phoneValue }}</span>
      </p>
    </div>
  </div>
</template>

<script setup>
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { Textarea } from '@/components/ui/textarea'
import { ref } from 'vue'
import { Terminal } from 'lucide-vue-next'
import { useToast } from '@/components/ui/toast/use-toast'
import { Toaster } from '@/components/ui/toast'
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
import axios from 'axios'

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
let middleNameValue = ref('')
let firstNameValue = ref('')
let lastNameValue = ref('')
let emailValue = ref('')
let textValue = ref('')

const { handleSubmit, errors } = useForm({
  validationSchema: formSchema
})

let isVisible = ref(true)

const onSubmit = handleSubmit(async (formData) => {
  const data = formData
  console.log(data)

  // Собираем данные

  phoneValue.value = data.phone
  fioValue.value = data.username
  emailValue.value = data.email
  textValue.value = data.textArea

  // Разделение на Фамилию имя и отчество

  const fioParts = data.username.split(' ')

  if (fioParts.length === 3) {
    lastNameValue.value = fioParts[0] // Фамилия
    firstNameValue.value = fioParts[1] // Имя
    middleNameValue.value = fioParts[2] // Отчество
  }

  console.log(data)

  // Готовим POST запрос

  const userData = new FormData()
  userData.append('fio', data.username)
  userData.append('email', data.email)
  userData.append('phone', data.phone)
  userData.append('text_message', data.textArea)

  try {
    const response = await axios.post('http://localhost/lab3/API-POST-DATA.php', userData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    console.log('Ответ от сервера:', response.data)

    const { toast } = useToast()

    let interval = Math.round(response.data.interval)

    if (response.data.status == 'No') {
      console.log(interval)
      toast({
        description: `Сообщение можно отправить раз в 1.5 часа. Осталось ${interval} минут(ы)`,
        variant: 'destructive'
      })
    } else if (response.data.status == 'Yes') {
      isVisible.value = false
    }
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
})
</script>

<style lang="scss" scoped></style>
