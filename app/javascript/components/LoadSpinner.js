import React from "react"
import Spinner from 'react-bootstrap/Spinner'
function LoadSpinner(props) {
    return(
        <Spinner animation={ props.animation } role={ props.role }>
            <span className="sr-only">{ props.message }</span>
        </Spinner>
    );
} 

export default LoadSpinner;