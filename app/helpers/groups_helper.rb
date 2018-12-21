module GroupsHelper
    def render_group_description_asd(group)
        #直接將裡面的值叫出來 像下面整串直接回傳
        simple_format(group.description)
    end


end
