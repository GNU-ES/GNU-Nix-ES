with import <nixpkgs> {
  overlays = [
   (self: super: {
     python3Slim =
       let smallPackage = self.pkgsMusl.python3.override {
             self = self.python3Slim;
             readline = null;
             ncurses = null;
             gdbm = null;
             sqlite = null;
           };
       in smallPackage.overrideAttrs (old: {
         postFixup = ''
           find $out -type d | grep -e 'test' -e 'tkinter' -e 'idle' | xargs rm -rf
           find $out -type d -iname '__pycache__' | xargs rm -rf
         '';
       });
   })
  ];
};
python3Slim
