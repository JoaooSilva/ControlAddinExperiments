pageextension 60002 "Customer List Ext" extends "Customer List"
{
    layout
    {
        //JOA003+ 
        addbefore(Control1)
        {
            usercontrol(Carousel; "Carousel AddIn")
            {
                trigger ControlReady()
                var
                    JObject: JsonObject;
                    Slides: JsonArray;
                begin
                    Slides.Add(AddSlide('Keep your promises', 'check before you make a promise', '//unsplash.it/1024/200'));
                    Slides.Add(AddSlide('Never forget', 'always register your conversations to ensure you follow-up promptly', '//unsplash.it/1025/200'));
                    Slides.Add(AddSlide('Qualify', 'be picky about which opportunities to spend time on', '//unsplash.it/1024/201'));
                    JObject.Add('slides', Slides);
                    CurrPage.Carousel.SetCarouselData(JObject);
                end;
            }
        }
        //JOA003-
    }
    //JOA003+ 
    local procedure AddSlide(Title: Text; Description: Text; Image: Text): JsonObject
    var
        Slide: JsonObject;
    begin
        Slide.Add('title', Title);
        Slide.Add('description', Description);
        Slide.Add('image', Image);
        exit(Slide);
    end;
    //JOA003-
}