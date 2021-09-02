// try{
    // let GET = require('./GET');
    // let POST = require('./POST');
    // let PUT = require('./PUT');
    // let DELETE = require('./DELETE');
    // let OPTIONS = require('./OPTIONS');
    // let DUMP = require('./DUMP');
    // }catch(e){console.log(e);}
    /**
     * Main field where we will fetch all the content and passer
     * @param  {[type]}   event    [description]
     * @param  {[type]}   context  [description]
     * @param  {Function} callback [description]
     * @return {[type]}            [description]
     */
    exports.handler = function(event,context,callback) {
        //TO DO HERE ...
        
        // context.callbackWaitsForEmptyEventLoop = false;
        // console.log(event.httpMethod);
        // switch(event.httpMethod){
        //     case 'GET': console.log(event.queryStringParameters,event.headers);
        //                 GET.execute(event.queryStringParameters,event.headers,callback);
        //                 break;
        //     case 'POST':console.log(event.body,event.headers); 
        //                 POST.execute(event.body,event.headers,callback);
        //                 break;
        //     case 'PUT': console.log(event.body,event.headers);
        //                 PUT.execute(event.body,event.headers,callback);
        //                 break;
        //     case 'DELETE':console.log(event.body,event.headers); 
        //                 DELETE.execute(event.body,event.headers,callback);
        //                 break;
        //     case 'PATCH': //for dev & prod
        //     case 'OPTIONS':
        //                 console.log(event.body,event.headers); 
        //                 OPTIONS.execute(event.body,event.headers,callback);
        //                 break;
        //     default : DUMP.execute(event,callback);
        // }
    }