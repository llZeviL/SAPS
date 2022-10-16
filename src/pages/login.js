import styled from "styled-components";
import Input from "../components/Input";
import { NavLink } from "react-router-dom";


export function Login() {
  return <MainContainer>
            <LoginText>Portal de Solicitudes</LoginText>
            <InputContainer>
              <Input type="text" placeholder="Rut Usuario"/>
              <br/>
              <Input type="password" placeholder="Contraseña "/>
            </InputContainer>
            <br/>
            <br/>
            
               <button className  ="ButtonContainer">
               <NavLink to="/home">Iniciar sesion</NavLink>
                </button> 
            
            <LoginWith>Redes Universitarias</LoginWith> 
        </MainContainer>;
}
const MainContainer = styled.div` 
  display: flex;
  align-items: center;
  flex-direction: column;
  height: 60vh;
  width: 30vw;
  background: rgba(255,255,255,0.80);  
  box-shadow: 0 8px 32px 0 rgba(31,38,135,0.2);
  backdrop-filter: blur(8.5);
  border-radius: 20px;
  color: black;
  text-transform: uppercase;
  letter-spacing: 0.1rem;  
`;
const LoginText = styled.h2`
  margin: 3rem 0 2rem 0;
  color: #051E64;
`;
const InputContainer =  styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  align-items: center;
  height: 20%;
  width: 95%;   
  
`;

const LoginWith = styled.h5`
   cursor: pointer;
   font-size: 1rem;

`;
