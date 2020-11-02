import React from "react"
const useModal = (WrappedComponent) => {
    class useModal extends React.Component {
        constructor(props) {
            super(props);
            
            this.state = {
                isVisible: false
            };

            this.toggleModal = this.toggleModal.bind(this);
        }

        toggleModal() {
            const isVisible = !this.state.isVisible;

            this.setState({
                isVisible: isVisible 
            });
        }

        render() {
            const {
                isVisible
            }= this.state;

            return (
                <WrappedComponent
                    isVisible={ isVisible }
                    toggleModal={  this.toggleModal }
                    {...this.props}
                />
            );
        }
    }
  
    useModal.displayName = `useModal(${WrappedComponent.name})`;

    return useModal;
  };
  
  export default useModal;