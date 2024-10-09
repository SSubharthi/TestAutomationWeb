class WebsitePage1 
{
    // constructor(browser) {
    //     this.browser = browser;
    //     this.pageTitle = "Automation";
    //     this.pageURL = "https://ultimateqa.com/automation";
    //     this.selectors = {
    //         components: "//*[contains(@class, 'et_pb_text_inner')]//a",
    //     };
    // }

    async open() {
        await browser.url("https://ultimateqa.com/automation");
        await browser.waitForElementVisible('body', 10000);
        await browser.assert.titleContains("Automation");
    }

    async checkTheLinksAndValidate()
    {

        //const text = await browser.elementIdText(elements[0].getId())
        //console.log(text);
        const countOfURLs = await browser.findElements("xpath", "//*[contains(@class, 'et_pb_text_inner')]//a");
        //console.log(elements.length);

        for (let i = 0; i < countOfURLs.length ; i++) 
        {
            const elements = await browser.findElements("xpath", "//*[contains(@class, 'et_pb_text_inner')]//a");
            const elementId = elements[i].getId();

            const expectedURL = await browser.elementIdAttribute(elementId, "href");

            await browser.url(expectedURL);
            await browser.pause(2000);

            await browser.verify.urlEquals(expectedURL);

            await browser.url("https://ultimateqa.com/automation");
            await browser.pause(2000);
        }
    }
}

module.exports = WebsitePage1;