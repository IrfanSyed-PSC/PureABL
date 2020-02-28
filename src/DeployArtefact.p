
/*------------------------------------------------------------------------
    File        : DeployArtefact.p
    Purpose     : 

    Syntax      :

    Description : ABL HTTP Client example to deploy a paar file to a PASOE Server

    Author(s)   : isyed
    Created     : Fri Feb 28 14:15:49 EST 2020
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING OpenEdge.Net.HTTP.HttpHeader FROM PROPATH.
USING OpenEdge.Net.HTTP.IHttpResponse FROM PROPATH.
USING OpenEdge.Net.HTTP.IHttpClient FROM PROPATH.
USING OpenEdge.Net.HTTP.ClientBuilder FROM PROPATH.
USING OpenEdge.Net.HTTP.Credentials FROM PROPATH.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */


def    var      fis     as Progress.IO.FileInputStream.
def    var      req     as OpenEdge.Net.HTTP.IHttpRequest.

def    var      oheader as HttpHeader.
def    var      oResp   as IHttpResponse.
def    var      oClient as IHttpClient.
DEFINE VARIABLE oCreds  AS Credentials                    NO-UNDO.

oCreds = NEW Credentials('application', 'tomcat', 'tomcat').
        
oheader = new HttpHeader("Content-Disposition","attachment; filename=SportsBEService.paar").

fis = new Progress.IO.FileInputStream('C:/temp/oeservices/SportsBEService.paar').

req = OpenEdge.Net.HTTP.RequestBuilder:Post('http://localhost:8810/oemanager/applications/fortest/webapps/oeabl/transports/rest/oeservices', fis)
            :ContentType('application/vnd.progress.paar+zip')
            :UsingBasicAuthentication(oCreds)
            :AcceptAll()
            :Request.
            
req:SetHeader(oheader).           



oClient = ClientBuilder:Build():Client.
oResp = oClient:Execute(req).

message oResp:StatusCode.
