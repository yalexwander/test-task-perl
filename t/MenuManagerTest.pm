package MenuManagerTest;
use strict;
use warnings;
use base 'TestCase';

use TestBuilder::MenuBuilder;

use MenuManager;
use MenuItem;
use SubmenuItem;


sub test_addMenuItemBefore {
    my $self = shift;

    my $manager = new MenuManager(
        TestBuilder::MenuBuilder::buildMenu()
    );

    $manager->addMenuItemBefore(
        "My menu 2",
        new MenuItem(title => "My menu 1/2")
    );

    $self->assert_num_equals(1, $manager->getMenu()->getMenuPosition('My menu 1/2'));

    $manager->addMenuItemBefore(
        "My menu",
        new MenuItem(title => "My menu 0/1")
    );

    $self->assert_num_equals(0, $manager->getMenu()->getMenuPosition('My menu 0/1'));
}


sub test_addMenuItemAfter {
    my $self = shift;

    my $manager = new MenuManager(
        TestBuilder::MenuBuilder::buildMenu()
    );

    $manager->addMenuItemAfter(
        "My menu",
        new MenuItem(title => "My menu 1/2")
    );

    $self->assert_num_equals(1, $manager->getMenu()->getMenuPosition('My menu 1/2'));

    $manager->addMenuItemAfter(
        "My menu 3",
        new MenuItem(title => "My menu last")
    );

    $self->assert_num_equals(4, $manager->getMenu()->getMenuPosition('My menu last'));
}


sub test_addSubmenuItemBefore {
    my $self = shift;

    my $manager = new MenuManager(
        TestBuilder::MenuBuilder::buildMenu()
    );

    $manager->addSubmenuItemBefore(
        "My menu",
        "Submenu3",
        new SubmenuItem(title => "My submenu new", url => "aaa")
    );

    my $newPath = $manager->_getSubmenuPath('My menu', 'My submenu new');

    $self->assert_num_equals(1, $newPath->{"pos"});
    $self->assert_num_equals(0, $manager->getMenu()->getMenuPosition(
        $newPath->{"menu"}->getAnchor
    ));
}

sub test_addSubmenuItemAfter {
    my $self = shift;

    my $manager = new MenuManager(
        TestBuilder::MenuBuilder::buildMenu()
    );

    $manager->addSubmenuItemAfter(
        "My menu",
        "Submenu3",
        new SubmenuItem(title => "My submenu new", url => "aaa")
    );

    my $newPath = $manager->_getSubmenuPath('My menu', 'My submenu new');

    $self->assert_num_equals(2, $newPath->{"pos"});
    $self->assert_num_equals(0, $manager->getMenu()->getMenuPosition(
        $newPath->{"menu"}->getAnchor
    ));
}



# ==================================
# sub test_return_true_on_addmenu
# {
#     my $self = shift;

#     my $manager = $self->_buildMenuManager();

#     $self->assert_num_equals(1, $manager->addMenu("My menu", [{title => "Submenu", url => 'abc'}]));
# }

# sub test_return_complete_menu
# {
#     my $self = shift;

#     my $manager = $self->_buildMenuManager();

#     $manager->addMenu("My menu", [{ title => "Submenu", url => 'abc' }]);

#     $self->assert_deep_equals(
#         [
#             {
#                 title   => "My menu",
#                 url     => '',
#                 submenu => [
#                     { title => "Submenu", url => 'abc' }
#                 ]
#             }
#         ],
#         [$manager->getMenu()]
#     );
# }

# sub test_add_menu_after
# {
#     my $self = shift;

#     my $manager = $self->_buildMenuManager();

#     $manager->addMenu("My menu1", [{ title => "Submenu1", url => 'abc' }]);
#     $manager->addMenu("My menu2", [{ title => "Submenu2", url => 'abc' }]);

#     $manager->addMenuAfter("My menu1", "My menu3", [{ title => "Submenu3", url => 'abc' }]);

#     $self->assert_deep_equals(
#         [
#             {
#                 title => "My menu1",
#                 url => '',
#                 submenu => [
#                     { title => "Submenu1", url => 'abc' }
#                 ]
#             },
#             {
#                 title => "My menu3",
#                 url => '',
#                 submenu => [
#                     { title => "Submenu3", url => 'abc' }
#                 ]
#             },
#             {
#                 title => "My menu2",
#                 url => '',
#                 submenu => [
#                     { title => "Submenu2", url => 'abc' }
#                 ]
#             }
#         ],
#         [$manager->getMenu()]
#     );
# }

# sub test_add_menu_before
# {
#     my $self = shift;

#     my $manager = $self->_buildMenuManager();

#     $manager->addMenu("My menu1", [{ title => "Submenu1", url => 'abc' }]);
#     $manager->addMenu("My menu2", [{ title => "Submenu2", url => 'abc' }]);

#     $manager->addMenuBefore("My menu1", "My menu3", [{ title => "Submenu3", url => 'abc' }]);

#     $self->assert_deep_equals(
#         [
#             {
#                 title => "My menu3",
#                 url => '',
#                 submenu => [
#                     { title => "Submenu3", url => 'abc' }
#                 ]
#             },
#             {
#                 title => "My menu1",
#                 url => '',
#                 submenu => [
#                     { title => "Submenu1", url => 'abc' }
#                 ]
#             },
#             {
#                 title => "My menu2",
#                 url => '',
#                 submenu => [
#                     { title => "Submenu2", url => 'abc' }
#                 ]
#             }
#         ],
#         [$manager->getMenu()]
#     );
# }

# sub test_add_sub_menu_before
# {
#     my $self = shift;

#     my $manager = $self->_buildMenuManager();

#     $manager->addMenu("My menu", [{ title => "Submenu1", url => 'abc1' }, { title => "Submenu2", url => 'abc2' }]);

#     $manager->addSubmenuBefore("My menu", "Submenu2", { title => "Submenu3", url => 'abc3' });

#     $self->assert_deep_equals(
#         [
#             {
#                 title => "My menu",
#                 url => '',
#                 submenu => [
#                     { title => "Submenu1", url => 'abc1' },
#                     { title => "Submenu3", url => 'abc3' },
#                     { title => "Submenu2", url => 'abc2' }
#                 ]
#             }
#         ],
#         [$manager->getMenu()]
#     );
# }

# sub test_add_sub_menu_after
# {
#     my $self = shift;

#     my $manager = $self->_buildMenuManager();

#     $manager->addMenu("My menu", [{ title => "Submenu1", url => 'abc1' }, { title => "Submenu2", url => 'abc2' }]);

#     $manager->addSubmenuAfter("My menu", "Submenu1", { title => "Submenu3", url => 'abc3' });

#     $self->assert_deep_equals(
#         [
#             {
#                 title => "My menu",
#                 url => '',
#                 submenu => [
#                     { title => "Submenu1", url => 'abc1' },
#                     { title => "Submenu3", url => 'abc3' },
#                     { title => "Submenu2", url => 'abc2' }
#                 ]
#             }
#         ],
#         [$manager->getMenu()]
#     );
# }

# sub test_throw_on_unknown_anchor_for_addmenu
# {
#     my $self = shift;

#     my $manager = $self->_buildMenuManager();

#     $self->assert_raises_matches(
#         'Error::Simple',
#         sub { $manager->addMenuBefore("Some unknown menu", "My menu3", [{ title => "Submenu3", url => 'abc' }]) },
#         qr/Anchor menu not found/
#     );
# }

# sub test_throw_on_unknown_anchor_for_addsubmenu
# {
#     my $self = shift;

#     my $manager = $self->_buildMenuManager();

#     $self->assert_raises_matches(
#         'Error::Simple',
#         sub { $manager->addSubmenuBefore("Some unknown menu", "Some unknown submenu", { title => "Submenu3", url => 'abc' }) },
#         qr/Anchor menu not found/
#     );
# }

# sub test_throw_on_unknown_subanchor_for_addsubmenu
# {
#     my $self = shift;

#     my $manager = $self->_buildMenuManager();

#     $manager->addMenu("My menu", [{ title => "Submenu1", url => 'abc1' }]);

#     $self->assert_raises_matches(
#         'Error::Simple',
#         sub { $manager->addSubmenuBefore("My menu", "Some unknown submenu", { title => "Submenu3", url => 'abc' }) },
#         qr/Anchor submenu not found/
#     );
# }

# sub _buildMenuManager
# {
#     my $self = shift;

#     return MenuManager->new(@_);
# }

1;
