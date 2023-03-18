local String = require('engine.util.String')

describe('Test String util', function ()
    
    it('replace string in string', function ()
        assert.are.same(String.replace('Hello World', 'World', 'Kitty'), 'Hello Kitty')
    end)

end)