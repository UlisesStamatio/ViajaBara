const Types = {
    getTypeFromImage(imageBase64){
        let extension = undefined; 
        const decodedString = window.atob(imageBase64); 
        const lowerCase = decodedString.toLowerCase();
        if (lowerCase.indexOf("png") !== -1) extension = "png"
        else if (lowerCase.indexOf("svg") !== -1) extension = "svg+xml"
        else if (lowerCase.indexOf("jpg") !== -1 || lowerCase.indexOf("jpeg") !== -1)
            extension = "jpg"
        return extension;
    }
}

export default Types;