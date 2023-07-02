import { useState } from 'react';
import {Box, Button,Checkbox,Select, TextInput } from '@mantine/core';
import { DatePickerInput } from '@mantine/dates';
import { useForm } from '@mantine/form';

const NONE = "NONE"
const INSERT_USER = "INSERT_USER"
const INSERT_JOB = "INSERT_JOB"
const ADD_REQUIREMENT = "ADD_REQUIREMENT"
const ADD_SKILL = "ADD_SKILL"
const GET_JOB = "GET_JOB"

const BASE_URL = "http://localhost:8000/api/"

const NonView = ({handleUpdateView}) => {
  return (
    <Box sx={{display:"flex", gap:16,}}>
      <Button onClick={()=>handleUpdateView(INSERT_USER)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>Insert User</Button>
      <Button onClick={()=>handleUpdateView(INSERT_JOB)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>Insert Job</Button>
      <Button onClick={()=>handleUpdateView(ADD_REQUIREMENT)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>Add Requirement</Button>
      <Button onClick={()=>handleUpdateView(ADD_SKILL)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>Add Skill</Button>
      <Button onClick={()=>handleUpdateView(GET_JOB)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>Get Job</Button>
    </Box>
  )

}

const InsertUser = () => {
  const form = useForm({
    initialValues: {
      first_name: '',
      last_name: '',
      username: "",
      password: "",
      address:"",
      gender:"male",
      is_working:false,
      phone_number:"",
      email_address:"",
      degree:"",
      birth_date:"",
    }
  });
  
  return <form onSubmit={form.onSubmit( async (values) => {
    let url = BASE_URL + "users/"
    values.gender = values.gender === "Male" ? 0 : 1
    // converting values birth date
    if (values.birth_date !== null){
      values.birth_date = values.birth_date.toI1SOString().split('T')[0]
    }
    // console.log(values.birth_date.toISOString().split('T')[0])

    let response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(values)
    })
    let data = await response.json()
    // checking status code
    if (response.status !== 201){
      // alert('fail')
    } else{
      // alert('user inserted with id: ' + data.id)
    }
    console.log(data)
  })}>
          <TextInput label="first_name" placeholder="Folan"  {...form.getInputProps('first_name')}/>
          <TextInput label="last_name" placeholder="Behaman"  {...form.getInputProps('last_name')}/>
          <TextInput label="username" placeholder="username" {...form.getInputProps('username')} />
          <TextInput label="password" type = 'password' placeholder="password" {...form.getInputProps('password')} />
          <TextInput label="address"  placeholder="Tehran, Iran" {...form.getInputProps('address')} />
          <TextInput label="phone_number" type='tel' placeholder="+98123456789"  {...form.getInputProps('phone_number')} />
          <TextInput label="email" type="email" placeholder="example@gmail.com"  {...form.getInputProps('email')}/>
          <Select
            mt="md"
            withinPortal
            data={['Under Graduate','Bachlor', 'Master', 'PHD']}
            placeholder="Bachlor"
            label="Degree"
            {...form.getInputProps('degree')}
          />          
          <Select
            mt="md"
            withinPortal
            data={['Male', 'Female']}
            placeholder="Male"
            label="Gender"
            {...form.getInputProps('gender')}
          />
          <Checkbox
            onChange={() => {}}
            mt="md"
            label="Is Working"
            tabIndex={-1}
            size="md"
            mr="xl"
            styles={{ input: { cursor: 'pointer' } }}
            {...form.getInputProps('is_working')}
          />
          <DatePickerInput
            mt="md"
            popoverProps={{ withinPortal: true }}
            label="Bitrh Date"
            placeholder="Your Birth Date"
            clearable={true}
            {...form.getInputProps('birth_date')}
          />
          <Button mt='lg' type='submit'>Submit</Button>
  </form>
}

const InsertJob = () => {
  const form = useForm({
    initialValues: {
      title: '',
      employer: '',
      description: '',
      employer: '',
      address:"",
      required_gender:"None",
      is_remote:false,
    }
  });
  
  return <form onSubmit={form.onSubmit( async (values) => {
    let url = BASE_URL + "jobs/"
    switch(values.required_gender){
      case "None":
        values.required_gender = 0
      case "Male":
        values.required_gender = 1
      case "Female":
        values.required_gender = 2
    }

    let response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(values)
    })
    let data = await response.json()
    // checking status code
    if (response.status !== 201){
      alert('fail')
    } else{
      alert('job inserted with id: ' + data.id)
    }
    console.log(data)
  })}>          
          <TextInput label="title" placeholder="title"  {...form.getInputProps('title')} />
          <TextInput label="employer" placeholder="employer"  {...form.getInputProps('employer')} />
          <TextInput label="description" placeholder="description"  {...form.getInputProps('description')} />
          <TextInput label="address"  placeholder="Tehran, Iran"  {...form.getInputProps('address')} />    
          <Select
            mt="md"
            withinPortal
            data={['None', 'Male', 'Female']}
            placeholder="Male"
            label="Required gender"
            {...form.getInputProps('required_gender')}
          />
          <Checkbox
            onChange={() => {}}
            mt="md"
            label="Is Remote"
            tabIndex={-1}
            size="md"
            mr="xl"
            styles={{ input: { cursor: 'pointer' } }}
            {...form.getInputProps('is_remote')}
          />

          <Button mt='lg' type='submit'>Submit</Button>
  </form>

}
let skills = ['New', 'Backend', 'Frontend', 'Django', 'React', 'Devops']
function find_skill_id(skill_name){
  for(let i=0;i<skills.length;i++){
    if(skills[i]===skill_name){
      return i+1
    }
  }
  return -1
}

const AddRequirement = () => {
  const form = useForm({
    initialValues: {
      id: 0,
      skill_name: ""
    }
  });

  return <form onSubmit={form.onSubmit( async (values) => {
    let url = BASE_URL + "jobs/" + values.id + "/"
    let job = await fetch(url).then(res => res.json())    
    let skill_id = find_skill_id(values.skill_name)
    console.log(job)
    job.skills.push(skill_id)
    console.log(job.skills)
    let response = await fetch(url, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(job)
    })

    let data = await response.json()
    // checking status code
    if (response.status !== 200){
      alert('fail with status: ' + response.status)
    } else{
      alert('job updated')
    }
    console.log(data)
  })}>   
          <TextInput label="job id" placeholder="job id" {...form.getInputProps('id')} />
          <Select
            mt="md"
            withinPortal
            data={skills}
            placeholder="Django"
            label="skills"
            {...form.getInputProps('skill_name')}
          />
          <Button mt='lg' type='submit'>Submit</Button>
  </form>

}

const AddSkill = () => {
  const form = useForm({
    initialValues: {
      id: 0,
      skill_name: ""
    }
  });

  return <form onSubmit={form.onSubmit( async (values) => {
    let url = BASE_URL + "users/" + values.id + "/"
    let user = await fetch(url).then(res => res.json())    
    // user.skills = user.skills + ',' + find_skill_id(values.skill_name)
    let skill_id = find_skill_id(values.skill_name)
    // appending skill id
    user.skills.push(skill_id)
    console.log(user.skills)
    let response = await fetch(url, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(user)
    })

    let data = await response.json()
    // checking status code
    if (response.status !== 200){
      alert('fail with status: ' + response.status)
    } else{
      alert('user updated: ')
    }
    console.log(data)
  })}>   
    <TextInput label="user id" placeholder="user id"  {...form.getInputProps('id')}/>
    <Select
      mt="md"
      withinPortal
      data={skills}
      placeholder="Django"
      label="skills"
      {...form.getInputProps('skill_name')}
    />
    
    <Button mt='lg' type='submit'>Submit</Button>
  </form>

}

const GetJobs = () => {
  const form = useForm({
    initialValues: {
      user_id: 0,
      skill_name: ""
    }
  });

  return <form onSubmit={form.onSubmit((values) => console.log(values))}>
    <TextInput label="user id" placeholder="user id" {...form.getInputProps('user_id')} />
    <Select
      mt="md"
      withinPortal
      data={skills}
      placeholder="Django"
      label="skills"
      {...form.getInputProps('skill_name')}
    />
    
    <Button mt='lg' type='submit'>Retrieve</Button>
  </form>

}

const mapViewToComponents = {
  [NONE]: NonView,
  [INSERT_USER]: InsertUser,
  [INSERT_JOB]: InsertJob,
  [ADD_REQUIREMENT]: AddRequirement,
  [ADD_SKILL]: AddSkill,
  [GET_JOB]: GetJobs,
}

function App() {
  const [view, setView] = useState(NONE);

  const Component = mapViewToComponents[view]
  return (
    <Component handleUpdateView={setView}/>
  );
}
export default App;
