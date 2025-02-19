*** Settings ***
Resource  resource.robot
Test Setup  Clear Database

*** Test Cases ***
Create New Reference
    #Book is created with information about authors, title, year, publisher
    Input New Reference Command
    Input New Reference  Philip Pullman  Kultainen Kompassi  1996  Tammi
    Input Quit Command
    Run Application
    Output Should Contain  Added a new reference.

Print References
    # All created references can be printed to the interface
    Input New Reference Command
    Input New Reference  Philip Pullman  Kultainen Kompassi  1996  Tammi
    Input Print Command
    Input Quit Command
    Run Application
    Output Should Contain  1: Philip Pullman | Kultainen Kompassi | Tammi (1996)

Store References In Database
    # When program is restarted, local references are still present
    Input New Reference Command
    Input New Reference  Philip Pullman  Kultainen Kompassi  1996  Tammi
    Input Quit Command
    Run Application
    Input New Reference Command
    Input New Reference  George R. R. Martin  Tuf Voyaging  2003  Meisha Merlin
    Input Print Command
    Input Quit Command
    Run Application
    Output Should Contain  1: Philip Pullman | Kultainen Kompassi | Tammi (1996)
    Output Should Contain  2: George R. R. Martin | Tuf Voyaging | Meisha Merlin (2003)

Delete References In Database
    # Reference does not show up anymore when printing and is deleted from the database
    Input New Reference Command
    Input New Reference  Philip Pullman  Kultainen Kompassi  1996  Tammi
    Delete Reference Of Index  1
    Input Print Command
    Input Quit Command
    Run Application
    Output Should Contain  References have not been added yet.

Export References Into Bibtex File
    # Interface has option to export the references, they are found somewhere in the filedrive as BibTeX
    Input New Reference Command
    Input New Reference  Philip Pullman  Kultainen Kompassi  1996  Tammi
    Input New Reference Command
    Input New Reference  George R. R. Martin  Tuf Voyaging  2003  Meisha Merlin
    Input Export Command
    Input Quit Command
    Run Application
    Export Message Should Contain  References exported to *your filepath* succesfully.

Edit A ReferenceReference edited
    # A single reference can be edited, and it saves in the database and shows correctly when printing
    Input New Reference Command
    Input New Reference  Philip Pullman  Kultainen Kompassi  1996  Tammi
    Input Edit Reference Command
    Choose Reference Index To Edit  1
    Input Edit Author Command
    Input Edited Reference Field  Carl Barks
    Input Quit Command
    Run Application
    Output Should Contain  Reference edited.

Add A Book Reference Using Doi
    # User can input DOI code, app checks that it is valid, imports correct data and saves it into database
    Input New Doi Command
    Input Doi  10.1007/3-540-45471-3
    Input Print Command
    Input Quit Command
    Run Application
    Output Should Contain  Added a new reference.
    Output Should Contain  1: Martti Penttonen and Erik Meineche Schmidt | Algorithm Theory — SWAT 2002 | Springer Berlin Heidelberg (2002)
    Format Database

*** Keywords ***
Clear Database
    Format Database
