import React from "react"
import Modal from 'react-bootstrap/Modal'
class FormModal extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        const {
            button,
            form,
            title,
            isVisible,
            toggleModal
        }=this.props

        return (
            <React.Fragment>
                { button } 
                <Modal
                    show={ isVisible }
                    onHide={ toggleModal }
                    backdrop="static"
                    keyboard={ false }
                >
                    <Modal.Header closeButton>
                        <Modal.Title>{ title }</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                        { form }
                    </Modal.Body>
                </Modal>
            </React.Fragment>
        );
    }
}
  
  export default FormModal;