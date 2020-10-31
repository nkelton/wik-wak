import React from "react"
import LocationHelper from "./helper/LocationHelper"
const withFetchClientLocationDetails = (WrappedComponent) => {
    class withFetchClientLocationDetails extends React.Component {
        constructor(props) {
            super(props);
            
            this.state = {
                clientLocationDetails: {
                    lat: '',
                    lng: '',
                    address: {},
                    ipAddress: '',
                    loading: true
                }
            }
        }

        componentDidMount() {
            LocationHelper.getClientPosition()
                .then((position) => {
                    const lat = position.coords.latitude;
                    const lng = position.coords.longitude;

                    this.setState(prevState => ({
                        clientLocationDetails: {
                            ...prevState.clientLocationDetails,
                            lat: lat, 
                            lng: lng
                        }
                    }));
                
                    return LocationHelper.getClientAddressDetails(lat, lng);
                }).then((addressDetails) => {
                    this.setState(prevState => ({
                        clientLocationDetails: {
                            ...prevState.clientLocationDetails,
                            address: addressDetails.address 
                        }
                    }));

                    return LocationHelper.getClientIpAddress()
                }).then((ipAddress) => {
                    this.setState(prevState => ({
                        clientLocationDetails: {
                            ...prevState.   clientLocationDetails,
                            ipAddress: ipAddress.ip,
                            loading: false
                        }
                    }));
                });
        }

        render() {
            const {
                clientLocationDetails,
            }= this.state;

            return (
                <WrappedComponent
                    clientLocationDetails={ clientLocationDetails }
                    {...this.props}
                />
            );
        }
    }
  
    withFetchClientLocationDetails.displayName = `withFetchClientLocationDetails(${WrappedComponent.name})`;

    return withFetchClientLocationDetails;
  };
  
  export default withFetchClientLocationDetails;