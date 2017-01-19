// custom mods
document.addEventListener("DOMContentLoaded", function(event) {

  // hide email right/sharing menu entries (as they do not work with some imap servers)
  var hideElements = [
    'body > main > md-sidenav > md-content > section > md-list > md-list-item > div > div.md-secondary-container > button:nth-child(2)',
    '.md-open-menu-container > md-menu-content > md-menu-item[ng-show*=additional]',
    '.md-open-menu-container > md-menu-content > md-menu-divider[ng-show*=additional]',
    '.md-open-menu-container > md-menu-content > md-menu-item[ng-show*="account.id"]',
    'md-dialog > md-dialog-content > div > md-autocomplete[md-selected-item-change="acl.addUser(user)"]',
    'md-dialog > md-dialog-content > div > md-icon',
  ];

  var css = hideElements.join(', ') + ' { display: none !important; }\n';
 
  css += 'input[ng-model="$AccountDialogController.account.identities[0].email"] { pointer-events: none; tabindex: -1; color: rgba(0,0,0,0.38);}'
 
  // insert styles
  var head = document.head || document.getElementsByTagName('head')[0];
  var style = document.createElement('style');
  
  style.type = 'text/css';
  if (style.styleSheet){
    style.styleSheet.cssText = css;
  } else {
    style.appendChild(document.createTextNode(css));
  }

  head.appendChild(style);

});
