const WebsitePage1 = require("../WebsitePages/page-objects/WebsitePage1");

describe("Open the website and check the URLs" , async function()
{
    let WebsitePageInstance;
    before(async function(browser)
    {
        WebsitePageInstance = new WebsitePage1(browser);
        await WebsitePageInstance.open();
    });

    it("Open the URLs and check if they are launching properly", async function(browser)
    {
        await WebsitePageInstance.checkTheLinksAndValidate();
    });

    after(async function(browser)
    {
        browser.quit();
    });
});