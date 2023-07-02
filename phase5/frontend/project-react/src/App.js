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


const NonView = ({handleUpdateView}) => {
  return (
    <Box sx={{display:"flex", gap:16,}}>
      <Button onClick={()=>handleUpdateView(INSERT_USER)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>{INSERT_USER}</Button>
      <Button onClick={()=>handleUpdateView(INSERT_JOB)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>{INSERT_JOB}</Button>
      <Button onClick={()=>handleUpdateView(ADD_REQUIREMENT)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>{ADD_REQUIREMENT}</Button>
      <Button onClick={()=>handleUpdateView(ADD_SKILL)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>{ADD_SKILL}</Button>
      <Button onClick={()=>handleUpdateView(GET_JOB)} variant="gradient" gradient={{ from: 'indigo', to: 'cyan' }}>{GET_JOB}</Button>
    </Box>
  )

}
// {
//   "username": "",
//   "first_name": "",
//   "last_name": "",
//   "date_joined": null,
//   "address": "",
//   "gender": null,
//   "birth_date": null,
//   "is_working": false,
//   "phone_number": null,
//   "email_address": null,
//   "degree": null,
// }


const InsertUser = () => {
  const form = useForm({
    initialValues: {
      user: {
        first_name: '',
        last_name: '',
        username: "",
        address:"",
        gender:"male",
        is_working:false,
        phone_number:"",
        email_address:"",
        degree:""
      },
    }
  });
  
  return <form onSubmit={(e)=>{e.preventDefault();console.log(form.getInputProps())}}>
          <TextInput label="first_name" placeholder="Folan"  />
          <TextInput label="last_name" placeholder="Behaman"  />
          <TextInput label="username" placeholder="username"  />
          <TextInput label="address"  placeholder="Tehran, Iran"  />
          <TextInput label="phone_number" type='tel' placeholder="+98123456789"  />
          <TextInput label="email_address" type="email" placeholder="example@gmail.com"  />
          <Select
            mt="md"
            withinPortal
            data={['Under Graduate','Bachlor', 'Master', 'PHD']}
            placeholder="Bachlor"
            label="Degree"
          />          
          <Select
            mt="md"
            withinPortal
            data={['Male', 'Female']}
            placeholder="Male"
            label="Gender"
          />
          <Checkbox
            onChange={() => {}}
            mt="md"
            label="Is Working"
            tabIndex={-1}
            size="md"
            mr="xl"
            styles={{ input: { cursor: 'pointer' } }}
          />
          <DatePickerInput
            mt="md"
            popoverProps={{ withinPortal: true }}
            label="Bitrh Date"
            placeholder="Your Birth DateWhen will you leave?"
            clearable={false}
          />
          <Button mt='lg' type='submit'>Submit</Button>
  </form>
}

  // "title": "",
  // "description": "",
  // "required_level": null,
  // "required_gender": null,
  // "benefit": "",
  // "is_remote": false,
  // "recommended_salary": null,
  // "address": "",
  // "required_graduation": null,
  // "is_active": false,
  // "employer": null,
  // "skills": []
const InsertJob = () => {
  const form = useForm({
    initialValues: {
      job: {
        title: '',
        description: '',
        required_gender: "",
        address:"",
        required_gender:"male",
        is_remote:false,
      },
    }
  });
  
  return <form onSubmit={(e)=>{e.preventDefault();console.log(form.getInputProps())}}>
          <TextInput label="title" placeholder="title"  />
          <TextInput label="description" placeholder="description"  />
          <TextInput label="address"  placeholder="Tehran, Iran"  />    
          <Select
            mt="md"
            withinPortal
            data={['None', 'Male', 'Female']}
            placeholder="Male"
            label="Gender"
          />
          <Checkbox
            onChange={() => {}}
            mt="md"
            label="Is Remote"
            tabIndex={-1}
            size="md"
            mr="xl"
            styles={{ input: { cursor: 'pointer' } }}
          />

          <Button mt='lg' type='submit'>Submit</Button>
  </form>

}
const AddRequirement = () => {
  return ADD_REQUIREMENT
}
const AddSkill = () => {
  return ADD_SKILL
}
const GetJobs = () => {
  return GET_JOB
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

  const handleClick = () => {
    setView("NONE");
  };
  const Component = mapViewToComponents[view]
  return (
    <Component handleUpdateView={setView}/>
  );
}
export default App;
