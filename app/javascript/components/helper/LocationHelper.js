class LocationHelper {
    static getClientPosition = (options) => {
        return new Promise(function (resolve, reject) {
            navigator.geolocation.getCurrentPosition(resolve, reject, options);
        });
    }

    static getClientIpAddress() {
        const IPIFY_URL = "https://api.ipify.org/?format=json"
        return fetch(IPIFY_URL)
          .then(response => response.json())
    }

    static getClientLocationDetails = (lat, lng) => {
        const OPEN_STREET_URL = 'https://nominatim.openstreetmap.org/reverse?'
        return (
            fetch(OPEN_STREET_URL + new URLSearchParams({
                format: 'json',
                lat: lat,
                lon: lng,
                zoom: 18,
                addressdetails: 1
            })).then(response => response.json())
        );
    }
}
export default LocationHelper